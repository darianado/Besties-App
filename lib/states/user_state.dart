import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/active_user.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/firestore_service.dart';

/// A [ChangeNotifier] which handles the user state.
///
/// 'user state' includes listening for changes in the user object served by the
/// Firebase Authentication package, as well as the custom data model containing
/// all related data (first name, bio, preferences, etc.) pertaining to the user in question.
///
/// This class is the first point of entry when dealing with user-specific
/// actions such as signing out, resetting passwords, etc., thus it should be served
/// using a [ChangeNotifierProvider] to all views which need access to
/// information or manipulation of the user state.
class UserState extends ChangeNotifier {
  final AuthService authService;
  final FirestoreService firestoreService;

  bool waitingOnFirestore = false;
  ActiveUser? _user;
  ActiveUser? get user => _user;

  /// Constructor for the UserState class. Starts listeners upon
  /// construction, and may call [notifyListeners] immediately hereafter.
  UserState({required this.authService, required this.firestoreService}) {
    onAppStart();
  }

  StreamSubscription<ActiveUser?>? _subscription;

  /// Main method responsible for creating and manipulating
  /// the [ActiveUser] object, as well as calling [notifyListeners].
  void onAppStart() {
    authService.user.listen((auth.User? userAuthEvent) {
      //print("Auth event: ${_user?.user?.uid}");
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
          //print("Firestore event: ${_user?.userData?.firstName}");
          notifyListeners();
        });
      }
    });
  }

  /// Testing method used to reset the UserState in case of testing features
  /// that are not directly available to logged in users (e.g. splash screen).
  Future<void> resetUserState() async {
    _user = null;
    notifyListeners();
  }

  /// Mirrored method of the [signIn] method of [AuthService]. Included for consistency.
  Future<void> signIn(String email, String password) async => await authService.signIn(email, password);

  /// Mirrored method of the [signUp] method of [AuthService]. Included for consistency.
  Future<void> signUp(String email, String password) async => await authService.signUp(email, password);

  /// Mirrored method of the [signOut] method of [AuthService]. Included for consistency.
  Future<void> signOut() async => await authService.signOut();

  /// Mirrored method of the [deleteAccount] method of [AuthService]. Included for consistency.
  Future<void> deleteAccount(String password) async => await authService.deleteAccount(password);

  /// Mirrored method of the [resetPassword] method of [AuthService]. Included for consistency.
  Future<void> resetPassword(String email) async => await authService.resetPassword(email);

  /// Mirrored method of the [changePassword] method of [AuthService]. Included for consistency.
  Future<void> changePassword(String currentPassword, String newPassword) async =>
      await authService.changePassword(currentPassword, newPassword);

  /// Mirrored method of the [sendVerificationEmail] method of [AuthService]. Included for consistency.
  Future<void> sendVerificationEmail() async => await authService.sendVerificationEmail();

  /// Mirrored method of the [startCheckingForVerifiedEmail] method of [AuthService]. Included for consistency.
  void startCheckingForVerifiedEmail() => authService.startCheckingForVerifiedEmail();

  /// Mirrored method of the [stopCheckingForVerifiedEmail] method of [AuthService]. Included for consistency.
  void stopCheckingForVerifiedEmail() => authService.stopCheckingForVerifiedEmail();
}
