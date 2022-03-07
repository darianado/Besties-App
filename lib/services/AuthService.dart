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
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
