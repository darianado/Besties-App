import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/active_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/services/firestore_service.dart';

class RecommendationsState extends ChangeNotifier {
  final FirestoreService firestoreService;

  bool loadingRecommendations = false;
  String? _currentQueueID;
  Preferences? _currentPreferences;

  RecommendationsState(User user, {required this.firestoreService}) {
    startListening(user);
  }

  StreamSubscription<DocumentSnapshot?>? _subscription;

  void startListening(User user) {
    firestoreService.loggedInUser(user).listen((ActiveUser activeUser) async {
      if (_currentPreferences == null || _currentPreferences != activeUser.userData?.preferences) {
        _currentPreferences = activeUser.userData?.preferences;

        loadingRecommendations = true;
        notifyListeners();

        _subscription?.cancel();
        _subscription = firestoreService.recommendationsStream(activeUser.user?.uid).listen((DocumentSnapshot<Map> event) {
          if (event.exists) {
            Map? data = event.data();

            final uniqueID = data?['queueID'];

            if (_currentQueueID == null || uniqueID != _currentQueueID) {
              _currentQueueID = uniqueID;
              loadingRecommendations = false;
              notifyListeners();
            }
          }
        });
      }
    });
  }
}
