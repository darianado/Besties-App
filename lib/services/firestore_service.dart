import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project_seg/models/User/ActiveUser.dart';
import 'package:project_seg/models/User/UserData.dart';

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

  void saveUserData(UserData data) {}
}
