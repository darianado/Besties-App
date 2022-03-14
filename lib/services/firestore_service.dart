import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project_seg/models/User/ActiveUser.dart';
import 'package:project_seg/models/User/UserData.dart';

import '../models/profile_container.dart';

class FirestoreService {
  final firestore.FirebaseFirestore _firebaseFirestore =
      firestore.FirebaseFirestore.instance;

  FirestoreService._privateConstructor();

  static final FirestoreService _instance =
      FirestoreService._privateConstructor();

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
      "bio":
          "Hello! This is my bio. This text is rather long, so we can check everything's working.",
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

  void saveUserData(UserData data) {}

  // Requests a List of recommended uids from Firebase.
  static Future<List<String>> getRecommendedUsers(String uid, int recs) async {
    HttpsCallable callable =
        FirebaseFunctions.instanceFor(region: 'europe-west2')
            .httpsCallable('requestRecommendations');

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
    List<String> uids = await getRecommendedUsers(uid, recs);

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot;

    if (uids.isEmpty) {
      querySnapshot = await _collectionRef
          .get();
    } else {
      querySnapshot = await _collectionRef
          .where(FieldPath.documentId, whereIn: uids)
          .get();
    }

    final users = querySnapshot.docs
        .map((doc) => UserData.fromSnapshot(doc as DocumentSnapshot<Map>))
        .toList();
    return users;
  }

  // Creates Profile Containers from a List of User Data.
  static Future<List<ProfileContainer>> getProfileContainers(
      String uid, int recs) async {
    List<UserData> data = await getProfileData(uid, recs);
    return data.map((e) => ProfileContainer(profile: e)).toList();
  }
}
