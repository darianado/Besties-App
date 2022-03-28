import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/active_user.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/firestore_service.dart';

class UserState extends ChangeNotifier {
  final AuthService _authService = AuthService.instance;
  final FirestoreService _firestoreService = FirestoreService.instance;

  ActiveUser? _user;
  ActiveUser? get user => _user;

  UserState._privateConstructor();
  static final UserState _instance = UserState._privateConstructor();
  static UserState get instance => _instance;

  StreamSubscription<ActiveUser?>? _subscription;

  void onAppStart() {
    _authService.user.listen((auth.User? userAuthEvent) {
      if (userAuthEvent == null) {
        _user = ActiveUser(user: userAuthEvent);
        _subscription?.cancel();
        notifyListeners();
      } else {
        _subscription = _firestoreService.loggedInUser(userAuthEvent).listen((ActiveUser userFirestoreEvent) {
          _user = userFirestoreEvent;
          notifyListeners();
        });
      }
    });
  }

  Future<void> signIn(String email, String password) async => await _authService.signIn(email, password);

  Future<void> signUp(String email, String password) async => await _authService.signUp(email, password);

  Future<void> signOut() async => await _authService.signOut();

  // Future<void> deleteAccount() async => await _authService.deleteAccount();
}
