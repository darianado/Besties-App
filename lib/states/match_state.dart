import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/services/firestore_service.dart';

/// A [ChangeNotifier] which handles the match state.
///
/// 'match state' includes listening for new matches a user may have,
/// and notifying any listeners of this. This class should be served
/// using a [ChangeNotifierProvider] to all views which
/// depends on the user's matches.
///
/// This class also contains methods for getting subsets of a user's matches.
class MatchState extends ChangeNotifier {
  final FirestoreService firestoreService;

  /// Constructor for the match state.
  MatchState({required this.firestoreService});

  List<UserMatch>? matches;

  /// Main method responsible for maintaining an up-to-date list of
  /// [UserMatch] objects, as well as calling [notifyListeners] upon changes to this list.
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
          element.messagesOrdered = event;
          notifyListeners();
        });
      });
    });
  }

  /// Returns a subset of all [UserMatch]es, in which there exists a chat thread.
  List<UserMatch>? get activeChats {
    return matches?.where((UserMatch element) => element.messages != null && element.messages!.isNotEmpty).toList();
  }

  /// Returns a subset of all [UserMatch]es, in which no chat thread exists.
  List<UserMatch>? get matchesWithNoChat {
    return matches?.where((UserMatch element) => element.messages == null || element.messages!.isEmpty).toList();
  }
}
