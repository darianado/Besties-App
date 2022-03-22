import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/models/User/ActiveUser.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/App/app_context.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/services/user_state.dart';

import '../models/profile_container.dart';

class FirestoreService {
  final firestore.FirebaseFirestore _firebaseFirestore = firestore.FirebaseFirestore.instance;

  FirestoreService._privateConstructor();

  static final FirestoreService _instance = FirestoreService._privateConstructor();

  static FirestoreService get instance => _instance;

  Stream<ActiveUser> loggedInUser(auth.User user) {
    return _firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .snapshots()
        .map((doc) => ActiveUser.fromSnapshot(user, (doc.exists) ? doc : null));
  }

  void signUpUser(String uid) {
    final demo = {
      "dob": DateTime.utc(2000, 07, 20),
      "firstName": "Amy",
      "lastName": "Garcia",
      "university": "King's College London",
      "gender": "non-binary",
      "relationshipStatus": "single",
      "bio": "Hello! This is my bio. This text is rather long, so we can check everything's working.",
      "interests": ["volunteering", "christian"],
      "location": {"lat": 51.48, "lon": 0.086},
      "preferences": {
        "interests": ["buddhism", "christian", "islam"],
        "maxAge": 30,
        "minAge": 18
      }
    };

    _firebaseFirestore.collection("users").doc(uid).set(demo);
  }


  // Requests a List of recommended uids from Firebase.
  static Future<List<String>> getRecommendedUsers(String uid, int recs) async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'europe-west2').httpsCallable('requestRecommendations');

    final resp = await callable.call(<String, dynamic>{
      'userId': uid,
      'recs': recs,
    });

    HashMap raw = HashMap.from(resp.data);

    List<String> uids = List<String>.from(raw['data']);
    return uids;
  }

  // Filters all  users based on recommended users' uids.
  static Future<List<UserData>> getProfileData(String uid, int recs) async {
    //List<String> uids = await getRecommendedUsers(uid, recs);
    List<String> uids = [];

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot;

    if (uids.isEmpty) {
      querySnapshot = await _collectionRef.get();
    } else {
      querySnapshot = await _collectionRef.where(FieldPath.documentId, whereIn: uids).get();
    }

    final users = querySnapshot.docs.map((doc) => UserData.fromSnapshot(doc as DocumentSnapshot<Map>)).toList();
    return users;
  }

  // Creates Profile Containers from a List of User Data.
  static Future<Queue<ProfileContainer>> getProfileContainers(String uid, int recs) async {
    List<UserData> data = await getProfileData(uid, recs);
    Queue<ProfileContainer> containerQueue = Queue();
    for (UserData userData in data) {
      containerQueue.add(ProfileContainer(profile: userData));
    }
    return containerQueue;
  }

  Stream<AppContext> appContext() {
    return _firebaseFirestore.collection("app").doc("context").snapshots().map((snapshot) => AppContext.fromSnapshot(snapshot));
  }

  Future<CategorizedInterests> fetchInterests() async {
    final snapshot = await _firebaseFirestore.collection("app").doc("context").collection("interests").get();
    return CategorizedInterests(categories: snapshot.docs.map((doc) => (Category.fromSnapshot(doc))).toList());
  }

  void setProfileImageUrl(String url) {
    UserState _userState = UserState.instance;

    String? uid = _userState.user?.user?.uid;

    if (uid != null) {
      _firebaseFirestore.collection("users").doc(uid).set({"profileImageUrl": url}, firestore.SetOptions(merge: true));
    }
  }

  Future<void> setUniversity(String userId, String university) async {
    return await _firebaseFirestore.collection("users").doc(userId).set({"university": university}, firestore.SetOptions(merge: true));
  }

  Future<void> setGender(String userId, String gender) async {
    return await _firebaseFirestore.collection("users").doc(userId).set({"gender": gender}, firestore.SetOptions(merge: true));
  }

  Future<void> setDateOfBirth(String userId, DateTime dateOfBirth) async {
    return await _firebaseFirestore.collection("users").doc(userId).set({"dob": dateOfBirth}, firestore.SetOptions(merge: true));
  }

  Future<void> setLike(String? profileId, String userId) async {
    await _firebaseFirestore.collection("users").doc(userId).set({
      'likes': firestore.FieldValue.arrayUnion([profileId])
    }, firestore.SetOptions(merge: true));

    //query database if profile document contains admirer ID already
    //then call set match
  }

  Future<void> setMatch(String? profileId, String userId) async {
    await _firebaseFirestore.collection("users").doc(profileId).set({
      'matches': firestore.FieldValue.arrayUnion([userId])
    }, firestore.SetOptions(merge: true));

    await _firebaseFirestore.collection("users").doc(userId).set({
      'matches': firestore.FieldValue.arrayUnion([profileId])
    }, firestore.SetOptions(merge: true));
  }

  Future<void> setBio(String userId, String bio) async {
    return await _firebaseFirestore.collection("users").doc(userId).set({"bio": bio}, firestore.SetOptions(merge: true));
  }

  Future<void> setRelationshipStatus(String userId, String relationshipStatus) async {
    return await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"relationshipStatus": relationshipStatus}, firestore.SetOptions(merge: true));
  }

  Future<void> setInterests(String userId, CategorizedInterests interests) async {
    return await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"categorizedInterests": interests.toList()}, firestore.SetOptions(merge: true));
  }

  void saveUserData(UserData data) {
    UserState _userState = UserState.instance;

    String? uid = _userState.user?.user?.uid;

    if (uid != null) {
      // The following two lines should probably be done differently, but this way we at least populate something.
      data.preferences = Preferences(interests: data.categorizedInterests ?? CategorizedInterests(categories: []), maxAge: 50, minAge: 20);
      data.location = GeoLocation(lat: 50, lon: 0);

      _firebaseFirestore.collection("users").doc(uid).set(data.toMap());
    }
  }
}
