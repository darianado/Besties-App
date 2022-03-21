import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_seg/models/User/UserData.dart';

class ActiveUser {
  final User? user;
  final UserData? userData;
  bool? emailVerified;

  ActiveUser({this.user, this.userData, this.emailVerified});

  factory ActiveUser.fromSnapshot(User user, DocumentSnapshot<Map>? doc) {
    return ActiveUser(user: user, userData: (doc != null) ? UserData.fromSnapshot(doc) : null, emailVerified: user.emailVerified);
  }

  bool get hasInconsistentState {
    return user != null && userData == null;
  }

  bool get isLoggedIn {
    return user != null && userData != null;
  }
}
