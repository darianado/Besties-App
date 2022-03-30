import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project_seg/models/App/app_context.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Matches/message.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/models/User/active_user.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/states/user_state.dart';

class FirestoreService {
  final firestore.FirebaseFirestore firebaseFirestore;
  final int batchSize = 10; // Determines how many splits we make when fetching profiles using array of userIDs

  FirestoreService({required this.firebaseFirestore});

  Stream<ActiveUser> loggedInUser(auth.User user) {
    return firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .snapshots()
        .map((doc) => ActiveUser.fromSnapshot(user, (doc.exists) ? doc : null));
  }

  Stream<firestore.DocumentSnapshot<Map>> recommendationsStream(String? userID) {
    return firebaseFirestore.collection("users").doc(userID).collection("derived").doc("recommendations").snapshots();
  }

  Stream<AppContext> appContext() {
    return firebaseFirestore.collection("app").doc("context").snapshots().map((snapshot) => AppContext.fromSnapshot(snapshot));
  }

  List<List<String>> split(List<String> lst, int size) {
    List<List<String>> results = [];

    for (var i = 0; i < lst.length; i += size) {
      final end = (i + size < lst.length) ? i + size : lst.length;
      results.add(lst.sublist(i, end));
    }

    return results;
  }

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

  Future<UserData> getUser(String userID) async {
    final _userDoc = await firebaseFirestore.collection("users").doc(userID).get();
    return UserData.fromSnapshot(_userDoc);
  }

  Stream<List<UserMatch>> listenForMatches(String userID) {
    return firebaseFirestore.collection("matches").where("uids", arrayContains: userID).snapshots().map((event) {
      return event.docs.map((e) => UserMatch.fromMatchSnapshot(e, userID)).toList();
    });
  }

  Stream<List<Message>?> listenForMessages(String matchID) {
    return firebaseFirestore.collection("matches").doc(matchID).collection("messages").snapshots().map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((e) => Message.fromSnapshot(e)).toList();
      }
      return null;
    });
  }

  // Saves a single message to firestore.
  Future<void> saveMessage(String matchID, Message message) async {
    firebaseFirestore.collection("matches").doc(matchID).collection("messages").add(message.toMap());
  }

  Future<CategorizedInterests> fetchInterests() async {
    final snapshot = await firebaseFirestore.collection("app").doc("context").collection("interests").get();
    return CategorizedInterests(categories: snapshot.docs.map((doc) => (Category.fromSnapshot(doc))).toList());
  }

  void setProfileImageUrl(String url, String? userID) {
    firebaseFirestore.collection("users").doc(userID).set({"profileImageUrl": url}, firestore.SetOptions(merge: true));
  }

  Future<void> setUniversity(String userId, String university) async {
    return await firebaseFirestore.collection("users").doc(userId).set({"university": university}, firestore.SetOptions(merge: true));
  }

  Future<void> setGender(String userId, String gender) async {
    return await firebaseFirestore.collection("users").doc(userId).set({"gender": gender}, firestore.SetOptions(merge: true));
  }

  Future<void> setDateOfBirth(String userId, DateTime dateOfBirth) async {
    return await firebaseFirestore.collection("users").doc(userId).set({"dob": dateOfBirth}, firestore.SetOptions(merge: true));
  }

  Future<bool> setLike(String? profileId) async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'europe-west2').httpsCallable('likeUser');
    final resp = await callable.call(<String, String>{
      'profileUserID': profileId.toString(),
    });

    HashMap raw = HashMap.from(resp.data);

    bool isMatch = raw['data']['matched'];

    return isMatch;
  }

  Future<void> setBio(String userId, String bio) async {
    return await firebaseFirestore.collection("users").doc(userId).set({"bio": bio}, firestore.SetOptions(merge: true));
  }

  Future<void> setRelationshipStatus(String userId, String relationshipStatus) async {
    return await firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"relationshipStatus": relationshipStatus}, firestore.SetOptions(merge: true));
  }

  Future<void> setInterests(String userId, CategorizedInterests interests) async {
    return await firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"categorizedInterests": interests.toList()}, firestore.SetOptions(merge: true));
  }

  Future<void> setPreferences(String userId, Preferences preferences) async {
    return await firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"preferences": preferences.toMap()}, firestore.SetOptions(merge: true));
  }

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
}
