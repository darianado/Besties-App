import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/ActiveUser.dart';
import 'package:project_seg/services/firestore_service.dart';

class RecommendationsState extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService.instance;

  bool loadingRecommendations = false;
  String? _currentQueueID;
  String? get currentQueueID => _currentQueueID;

  RecommendationsState(User user) {
    startListening(user);
  }

  StreamSubscription<DocumentSnapshot?>? _subscription;

  void startListening(User user) {
    _firestoreService.loggedInUser(user).listen((ActiveUser activeUser) async {
      if (_currentQueueID != null && activeUser.userData?.preferences?.queueID == _currentQueueID) {
        print("Queue not changed!");
        return;
      }

      loadingRecommendations = true;
      notifyListeners();

      _subscription?.cancel();
      _subscription = _firestoreService.recommendationsStream(activeUser.user?.uid).listen((DocumentSnapshot<Map> event) {
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
    });
  }
}
