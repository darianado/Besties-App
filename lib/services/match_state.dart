import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/services/firestore_service.dart';

class MatchState extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService.instance;

  MatchState._privateConstructor();
  static final MatchState _instance = MatchState._privateConstructor();
  static MatchState get instance => _instance;

  List<UserMatch>? matches;

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

      matches = await Future.wait(event.map((e) async {
        final fetchedMatch = await _firestoreService.getUser(e.match!.uid!);
        e.match = fetchedMatch;
        return e;
      }).toList());

      notifyListeners();

      matches?.forEach((UserMatch element) {
        _firestoreService.listenForMessages(element.matchID).listen((event) {
          element.messages = event;
          notifyListeners();
        });
      });
    });
  }

  List<UserMatch>? get activeChats {
    return matches?.where((UserMatch element) => element.messages != null).toList();
  }

  List<UserMatch>? get matchesWithNoChat {
    return matches?.where((UserMatch element) => element.messages == null).toList();
  }
}
