import 'package:flutter/material.dart';
import 'package:project_seg/services/firestore_service.dart';

class MatchState extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService.instance;

  MatchState._privateConstructor();
  static final MatchState _instance = MatchState._privateConstructor();
  static MatchState get instance => _instance;

  List<String>? matches;

  void onStart(String userID) {
    _firestoreService.fetchMatches(userID).listen((List<String> event) {
      matches = event;
      print("Matches changed!");
      notifyListeners();
    });
  }
}
