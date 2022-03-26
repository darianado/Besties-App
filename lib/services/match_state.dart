import 'package:flutter/material.dart';
import 'package:project_seg/models/User/Match.dart';
import 'package:project_seg/models/User/OtherUser.dart';
import 'package:project_seg/services/firestore_service.dart';

class MatchState extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService.instance;

  MatchState._privateConstructor();
  static final MatchState _instance = MatchState._privateConstructor();
  static MatchState get instance => _instance;

  List<OtherUser>? matches;

  void onStart(String userID) {
    _firestoreService.listenForMatches(userID).listen((List<UserMatch> event) async {
      event.sort((a, b) {
        final aTimestamp = a.timestamp;
        final bTimestamp = b.timestamp;

        if (aTimestamp != null && bTimestamp != null) {
          return bTimestamp.compareTo(aTimestamp);
        } else {
          return 0;
        }
      });
      List<String> sortedUserIDs = event.map((e) => e.matchUserID!).toList();

      print("Sorted event: ${sortedUserIDs}");

      matches = await _firestoreService.getUsers(sortedUserIDs);
      print("Matches: ${matches?.map((e) => "UID: ${e.userData.uid}, name: ${e.userData.firstName}")}");
      print("Matches changed!");
      notifyListeners();
    });
  }
}
