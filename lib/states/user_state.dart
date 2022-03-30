import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/active_user.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/firestore_service.dart';

class UserState extends ChangeNotifier {
  final AuthService authService;
  final FirestoreService firestoreService;

  bool waitingOnFirestore = false;
  ActiveUser? _user;
  ActiveUser? get user => _user;

  UserState({required this.authService, required this.firestoreService}) {
    onAppStart();
  }

  StreamSubscription<ActiveUser?>? _subscription;

  void onAppStart() {
    authService.user.listen((auth.User? userAuthEvent) {
      if (userAuthEvent == null) {
        _user = ActiveUser(user: userAuthEvent);
        _subscription?.cancel();
        notifyListeners();
      } else {
        waitingOnFirestore = true;
        _user = ActiveUser(user: userAuthEvent);
        notifyListeners();
        _subscription = firestoreService.loggedInUser(userAuthEvent).listen((ActiveUser userFirestoreEvent) {
          waitingOnFirestore = false;
          _user = userFirestoreEvent;
          //print("We got a user object: ${_user?.userData?.firstName}");
          notifyListeners();
        });
      }
    });
  }

  /**
   * Testing method used to reset the UserState in case of testing features
   * that are not directly available to logged in users (e.g. splash screen).
   */
  Future<void> resetUserState() async {
    _user = null;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async => await authService.signIn(email, password);

  Future<void> signUp(String email, String password) async => await authService.signUp(email, password);

  Future<void> signOut() async => await authService.signOut();

  Future<void> deleteAccount(String password) async => await authService.deleteAccount(password);

  Future<void> resetPassword(String email) async => await authService.resetPassword(email);

  Future<void> changePassword(String currentPassword, String newPassword) async =>
      await authService.changePassword(currentPassword, newPassword);

  Future<void> sendVerificationEmail() async => await authService.sendVerificationEmail();

  void startCheckingForVerifiedEmail() => authService.startCheckingForVerifiedEmail();

  void stopCheckingForVerifiedEmail() => authService.stopCheckingForVerifiedEmail();

  // Future<void> deleteAccount() async => await _authService.deleteAccount();
}
