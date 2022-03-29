import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' as mockAuth;

class AuthService {
  final auth.FirebaseAuth firebaseAuth;

  Timer? timer;

  AuthService({required this.firebaseAuth});

  Stream<auth.User?> get user {
    return firebaseAuth.userChanges();
  }

  auth.User? get currentUser {
    return firebaseAuth.currentUser;
  }

  Future<void> signIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((_) async {
      await sendVerificationEmail();
    });
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  Future<void> deleteAccount(String password) async {
    final verified = await validatePassword(password);
    if (verified) {
      return await firebaseAuth.currentUser?.delete();
    }
  }

  Future<void> sendVerificationEmail() async {
    await currentUser?.sendEmailVerification(null);
  }

  Future<void> reloadUser() async {
    try {
      await firebaseAuth.currentUser?.reload();
    } catch (e) {
      // calling reload on a null user.
      return;
    }
  }

  void startCheckingForVerifiedEmail() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await reloadUser();
      if (currentUser?.emailVerified == true) {
        timer.cancel();
      }
    });
  }

  void stopCheckingForVerifiedEmail() {
    timer?.cancel();
  }

  Future<void> resetPassword(String email) async {
    //TO DO check if user with that email is verified before sending password reset
    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> changePassword(String currentPassword, String newPassword) async {
    auth.User? user = currentUser;
    if (user == null) {
      return;
    }

    await validatePassword(currentPassword);
    await user.updatePassword(newPassword);
  }

  Future<bool> validatePassword(String password) async {
    auth.User? user = currentUser;
    if (user == null) {
      return false;
    }

    final credentials = auth.EmailAuthProvider.credential(email: user.email!, password: password);
    await user.reauthenticateWithCredential(credentials);
    return true;
  }
}
