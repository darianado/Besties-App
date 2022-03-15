import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project_seg/models/User/ActiveUser.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/App/app_context.dart';
import 'package:project_seg/models/Interests/category.dart';
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

  Future<void> setBio(String userId, String bio) async {
    return await _firebaseFirestore.collection("users").doc(userId).set({"bio": bio}, firestore.SetOptions(merge: true));
  }

  Future<void> setRelationshipStatus(String userId, String relationshipStatus) async {
    return await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .set({"relationshipStatus": relationshipStatus}, firestore.SetOptions(merge: true));
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
