import 'dart:collection';
import 'dart:convert';
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

  Stream<firestore.DocumentSnapshot> recommendationsStream(String? userID) {
    return _firebaseFirestore.collection("users").doc(userID).collection("derived").doc("recommendations").snapshots();
  }

  /// Returns a List of recommended profile ids.
  static Future<List<String>> getRecommendedProfiles(String uid, int recs) async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'europe-west2').httpsCallable('requestRecommendations');
    final resp = await callable.call(<String, dynamic>{
      'uid': uid,
      'recs': recs,
    });

    return List<String>.from(resp.data['data']);
  }

  /// Returns a List of [UserData] from a List of profile ids.
  static Future<List<UserData>> getProfileData(String uid, int recs) async {
    //List<String> uids = await getRecommendedProfiles(uid, recs);

    List<String> uids = [];

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot;

    if (uids.isEmpty) {
      querySnapshot = await _collectionRef.get();
    } else {
      querySnapshot = await _collectionRef.where(FieldPath.documentId, whereIn: uids).get();
    }

    return querySnapshot.docs.map((doc) => UserData.fromSnapshot(doc as DocumentSnapshot<Map>)).toList();
  }

  /// Returns a Queue of [ProfileContainer]s from a List of [UserData].
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

  Future<bool> setLike(String? profileId, String userId) async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'europe-west2').httpsCallable('likeUser');
    final resp = await callable.call(<String, String>{
      'profileUserID': profileId.toString(),
    });

    HashMap raw = HashMap.from(resp.data);

    bool isMatch = raw['data']['matched'];

    return isMatch;
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

  Future<void> setPreferences(String userId, Preferences preferences) async {
    return await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"preferences": preferences.toMap()}, firestore.SetOptions(merge: true));
  }

  void saveUserData(UserData data) {
    UserState _userState = UserState.instance;

    String? uid = _userState.user?.user?.uid;

    if (uid != null) {
      // The following two lines should probably be done differently, but this way we at least populate something.
      data.preferences = Preferences(
        interests: data.categorizedInterests ?? CategorizedInterests(categories: []),
        genders: [data.gender],
        maxAge: 50,
        minAge: 20,
      );

      _firebaseFirestore.collection("users").doc(uid).set(data.toMap());
    }
  }
}
