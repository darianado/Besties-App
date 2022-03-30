import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/services/firestore_service.dart';

class MatchState extends ChangeNotifier {
  final FirestoreService firestoreService;

  MatchState({required this.firestoreService});

  List<UserMatch>? matches;

  void onStart(String userID) {
    firestoreService.listenForMatches(userID).listen((List<UserMatch> event) async {
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
        final fetchedMatch = await firestoreService.getUser(e.match!.uid!);
        e.match = fetchedMatch;
        return e;
      }).toList());

      notifyListeners();

      matches?.forEach((UserMatch element) {
        firestoreService.listenForMessages(element.matchID).listen((event) {
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
