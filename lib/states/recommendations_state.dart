import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/active_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/services/firestore_service.dart';

/// A [ChangeNotifier] which handles the recommendations state.
///
/// 'recommendations state' includes listening for changes in the recommendations
/// stored in Firebase for a specific user. The sole responsibility of this
/// class is to detect and notify of a change to the recommended users, by first
/// listening for changes to the 'preferences' of the currently logged in user,
/// and then listen for the following change to the recommendations queue.
class RecommendationsState extends ChangeNotifier {
  final FirestoreService firestoreService;

  bool loadingRecommendations = false;
  String? _currentQueueID;
  Preferences? _currentPreferences;

  /// Constructor for the RecommendationsState class. Starts listening upon
  /// construction, and may call [notifyListeners] immediately hereafter.
  RecommendationsState(User user, {required this.firestoreService}) {
    startListening(user);
  }

  StreamSubscription<DocumentSnapshot?>? _subscription;

  /// Main method responsible for listening for upcoming and finished updates
  /// to the recommendations state.
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
