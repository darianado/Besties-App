import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_seg/models/User/user_data.dart';

/// An [ActiveUser].
class ActiveUser {
  final User? user;
  final UserData? userData;
  List<Match>? matches;
  bool? emailVerified;

  ActiveUser({this.user, this.userData, this.emailVerified, this.matches});

  /// This factory creates an instance of [ActiveUser] from a [DocumentSnapshot].
  factory ActiveUser.fromSnapshot(User user, DocumentSnapshot<Map>? doc) {
    return ActiveUser(
        user: user,
        userData:
            (doc != null && doc.exists) ? UserData.fromSnapshot(doc) : null,
        emailVerified: user.emailVerified);
  }

  /// Checks if the [user] has no [userData]
  bool get hasInconsistentState {
    return user != null && userData == null;
  }

  /// Checks if the [user] is logged in.
  bool get isLoggedIn {
    return user != null && userData != null;
  }
}
