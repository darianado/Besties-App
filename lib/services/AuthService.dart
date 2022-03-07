import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  AuthService._privateConstructor();

  static final AuthService _instance = AuthService._privateConstructor();

  static AuthService get instance => _instance;

  Stream<auth.User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  auth.User? get currentUser {
    return _firebaseAuth.currentUser;
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((_) async {
      await sendVerificationEmail();
    });
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<void> sendVerificationEmail() async {
    await currentUser?.sendEmailVerification(null);
  }

  Future<void> resetPassword(String email) async {
    //TO DO check if user with that email is verified before sending password reset
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
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
