import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project_seg/models/App/app_context.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Matches/message.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/models/User/active_user.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/utility/helpers.dart';

/// Collects methods related to Firestore.
class FirestoreService {
  final firestore.FirebaseFirestore firebaseFirestore;
  final int batchSize = 10; // Determines how many splits to make when fetching profiles using array of userIDs

  /// Constructor for the [FirestoreService] class.
  ///
  /// In testing, a [FakeFirebaseFirestore] object may be passed here.
  /// In production, a [FirebaseFirestore] object should be passed.
  FirestoreService({required this.firebaseFirestore});

  /// Returns a stream of [ActiveUser] based on a Firebase Authentication [User] object.
  Stream<ActiveUser> loggedInUser(auth.User user) {
    return firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .snapshots()
        .map((doc) => ActiveUser.fromSnapshot(user, (doc.exists) ? doc : null));
  }

  /// Returns a stream of [DocumentSnapshot] describing the recommendations for a given user.
  Stream<firestore.DocumentSnapshot<Map>> recommendationsStream(String? userID) {
    return firebaseFirestore.collection("users").doc(userID).collection("derived").doc("recommendations").snapshots();
  }

  /// Returns a stream of [AppContext] objects, describing the context in which the application is running.
  Stream<AppContext> appContext() {
    return firebaseFirestore.collection("app").doc("context").snapshots().map((snapshot) => AppContext.fromSnapshot(snapshot));
  }

  /*
  Future<List<OtherUser>> getUsers(List<String> userIDs) async {
    List<List<String>> splitUserIDs = split(userIDs, batchSize);

    List<OtherUser> results = [];

    for (int si = 0; si < splitUserIDs.length; si++) {
      List<String> slice = splitUserIDs[si];

      final snapshot = await FirebaseFirestore.instance.collection("users").where(FieldPath.documentId, whereIn: slice).get();
      results.addAll(
        snapshot.docs.map((doc) {
          final userData = UserData.fromSnapshot(doc);
          return OtherUser(liked: false, userData: userData);
        }).toList(),
      );
    }

    results.sort((a, b) {
      final aUserID = a.userData.uid;
      final bUserID = b.userData.uid;
      final aPosOriginal = userIDs.indexWhere((element) => element == aUserID);
      final bPosOriginal = userIDs.indexWhere((element) => element == bUserID);

      return aPosOriginal.compareTo(bPosOriginal);
    });

    return results;
  }
  */

  /// Returns a [UserData] representation of the user indicated by [userID], as stored in Firestore.
  Future<UserData> getUser(String userID) async {
    final _userDoc = await firebaseFirestore.collection("users").doc(userID).get();
    return UserData.fromSnapshot(_userDoc);
  }

  /// Returns a stream of list of [UserMatch] objects, which represent matches for a user given by [userID].
  Stream<List<UserMatch>> listenForMatches(String userID) {
    return firebaseFirestore.collection("matches").where("uids", arrayContains: userID).snapshots().map((event) {
      return event.docs.map((e) => UserMatch.fromSnapshot(e, userID)).toList();
    });
  }

  /// Returns a stream of list of [Message] objects, which
  /// represent messages for a match between users given by [matchID].
  Stream<List<Message>?> listenForMessages(String matchID) {
    return firebaseFirestore.collection("matches").doc(matchID).collection("messages").snapshots().map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((e) => Message.fromSnapshot(e)).toList();
      }
      return null;
    });
  }

  /// Saves a single message to the Firestore document of a specific match indicated by [matchID].
  Future<void> saveMessage(String matchID, Message message) async {
    firebaseFirestore.collection("matches").doc(matchID).collection("messages").add(message.toMap());
  }

  /// Returns a [CategorizedInterests] of all possible interests as described in the app context.
  Future<CategorizedInterests> fetchInterests() async {
    final snapshot = await firebaseFirestore.collection("app").doc("context").collection("interests").get();
    return CategorizedInterests(categories: snapshot.docs.map((doc) => (Category.fromSnapshot(doc))).toList());
  }

  /// Sets the [profileImageUrl] for a user given by [userID] to the [url] provided.
  void setProfileImageUrl(String url, String? userID) {
    firebaseFirestore.collection("users").doc(userID).set({"profileImageUrl": url}, firestore.SetOptions(merge: true));
  }

  /// Sets the [university] for a user given by [userID] to the [university] provided.
  Future<void> setUniversity(String userId, String university) async {
    return await firebaseFirestore.collection("users").doc(userId).set({"university": university}, firestore.SetOptions(merge: true));
  }

  /// Sets the [gender] for a user given by [userID] to the [gender] provided.
  Future<void> setGender(String userId, String gender) async {
    return await firebaseFirestore.collection("users").doc(userId).set({"gender": gender}, firestore.SetOptions(merge: true));
  }

  /// Sets the [dob] for a user given by [userID] to the [dateOfBirth] provided.
  Future<void> setDateOfBirth(String userId, DateTime dateOfBirth) async {
    return await firebaseFirestore.collection("users").doc(userId).set({"dob": dateOfBirth}, firestore.SetOptions(merge: true));
  }

  /// Handles the liking of a user indicated with [profileID] by the currently logged in user.
  ///
  /// If this function is called from a testing context (where this class is instantiated
  /// with a [FakeFirebaseFirestore]), the function will return a mock value. This is because
  /// Firebase Functions are not supported from a testing context.
  Future<bool> setLike(String? profileID) async {
    if (firebaseFirestore is FakeFirebaseFirestore) {
      if (profileID == "john123") {
        return true;
      } else {
        return false;
      }
    }

    HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'europe-west2').httpsCallable('likeUser');
    final resp = await callable.call(<String, String>{
      'profileUserID': profileID.toString(),
    });

    HashMap raw = HashMap.from(resp.data);

    bool isMatch = raw['data']['matched'];

    return isMatch;
  }

  /// Sets the [bio] for a user given by [userID] to the [bio] provided.
  Future<void> setBio(String userId, String bio) async {
    return await firebaseFirestore.collection("users").doc(userId).set({"bio": bio}, firestore.SetOptions(merge: true));
  }

  /// Sets the [relationshipStatus] for a user given by [userID] to the [relationshipStatus] provided.
  Future<void> setRelationshipStatus(String userId, String relationshipStatus) async {
    return await firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"relationshipStatus": relationshipStatus}, firestore.SetOptions(merge: true));
  }

  /// Sets the [categorizedInterests] for a user given by [userID] to the [interests] provided.
  Future<void> setInterests(String userId, CategorizedInterests interests) async {
    return await firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"categorizedInterests": interests.toList()}, firestore.SetOptions(merge: true));
  }

  /// Sets the [preferences] for a user given by [userID] to the [preferences] provided.
  Future<void> setPreferences(String userId, Preferences preferences) async {
    return await firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"preferences": preferences.toMap()}, firestore.SetOptions(merge: true));
  }

  /// Saves a [UserData] object to Firestore in a document with the same ID as [userID].
  ///
  /// This action will overwrite any existing document stored with the same ID.
  /// As this method is intended only for use in the sign up process, a [Preferences]
  /// object is created with default parameters and associated to the data before upload.
  void saveUserData(UserData data, String? userID) {
    if (userID != null) {
      // The following two lines should probably be done differently, but this way we at least populate something.
      data.preferences = Preferences(
        interests: data.categorizedInterests ?? CategorizedInterests(categories: []),
        genders: [data.gender],
        maxAge: 50,
        minAge: 20,
      );

      firebaseFirestore.collection("users").doc(userID).set(data.toMap());
    }
  }

  /*
  //Gets the matchID from two uids.
  Future<String> getMatchID(String? userID, String? profileID) async {
    final snapshot = await firebaseFirestore.collection("matches").where("uids", isEqualTo: [userID, profileID]).get();

    String matchID = snapshot.docs.first.id;
    return matchID;
  }

  // Gets a list of messages in a match.
  Future<List<Message>> getMessageList(String senderID, String receiverID) async {
    List<Message> results = [];
    String matchID = await getMatchID(senderID, receiverID);

    final snapshot = await FirebaseFirestore.instance.collection("matches").doc(matchID).collection("messages").get();

    results.addAll(snapshot.docs.map((doc) => Message.fromSnapshot(doc)));
    results.sort(((a, b) => a.timestamp!.compareTo(b.timestamp!)));

    return results;
  }
  */
}
