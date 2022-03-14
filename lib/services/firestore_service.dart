import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project_seg/models/User/ActiveUser.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/app_context.dart';
import 'package:project_seg/models/category.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/services/user_state.dart';

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

  Stream<AppContext> appContext() {
    return _firebaseFirestore.collection("app").doc("context").snapshots().map((snapshot) => AppContext.fromSnapshot(snapshot));
  }

  Future<List<Category>> fetchInterests() async {
    final snapshot = await _firebaseFirestore.collection("app").doc("context").collection("interests").get();
    return snapshot.docs.map((doc) => (Category.fromSnapshot(doc))).toList();
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

  Future<void> setBio(String userId, String bio) async {
    return await _firebaseFirestore.collection("users").doc(userId).set({"bio": bio}, firestore.SetOptions(merge: true));
  }

  Future<void> setRelationshipStatus(String userId, String relationshipStatus) async {
    return await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"relationshipStatus": relationshipStatus}, firestore.SetOptions(merge: true));
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

  void saveUserData(UserData data) {
    final dataMap = {
      "dob": data.dob,
      "firstName": data.firstName,
      "lastName": data.lastName,
      "university": data.university,
      "gender": data.gender,
      "relationshipStatus": data.relationshipStatus,
      "bio": data.bio,
      "profileImageUrl": data.profileImageUrl,
      "interests": data.flattenedInterests?.map((e) => e.title).toList(),
      "location": {"lat": 51.48, "lon": 0.086},
      "preferences": {
        "interests": data.flattenedInterests?.map((e) => e.title).toList(),
        "maxAge": (data.age != null) ? data.age! + 2 : 50,
        "minAge": (data.age != null) ? data.age! - 2 : 18
      }
    };

    UserState _userState = UserState.instance;

    String? uid = _userState.user?.user?.uid;

    if (uid != null) {
      _firebaseFirestore.collection("users").doc(uid).set(dataMap);
    }
  }
}
