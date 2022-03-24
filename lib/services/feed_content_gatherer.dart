import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/profile_container.dart';
import 'package:project_seg/services/auth_service.dart';

class FeedContentGatherer extends ChangeNotifier {
  final int queueSize = 10;
  final int batchSize = 10;

  final AuthService _authService = AuthService.instance;

  FeedContentGatherer._privateConstructor();
  static final FeedContentGatherer _instance = FeedContentGatherer._privateConstructor();
  static FeedContentGatherer get instance => _instance;

  Future<List<String>> getRecommendedUserIDs(String userID, int amount) async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'europe-west2').httpsCallable('requestRecommendations');
    final resp = await callable.call(<String, dynamic>{
      'uid': userID,
      'recs': amount,
    });

    //await Future.delayed(Duration(seconds: 12));

    return List<String>.from(resp.data['data']);
  }

  List<List<String>> split(List<String> lst, int size) {
    List<List<String>> results = [];

    for (var i = 0; i < lst.length; i += size) {
      final end = (i + size < lst.length) ? i + size : lst.length;
      results.add(lst.sublist(i, end));
    }

    return results;
  }

  Future<List<UserData>> getUsers(List<String> userIDs) async {
    List<List<String>> splitUserIDs = split(userIDs, batchSize);

    List<UserData> results = [];

    for (int si = 0; si < splitUserIDs.length; si++) {
      List<String> slice = splitUserIDs[si];

      final snapshot = await FirebaseFirestore.instance.collection("users").where(FieldPath.documentId, whereIn: slice).get();
      results.addAll(
        snapshot.docs.map((doc) => UserData.fromSnapshot(doc)).toList(),
      );
    }

    return results;
  }

  List<Widget> constructWidgetsFromUserData(List<UserData> userDataLst) {
    return userDataLst.map((e) => ProfileContainer(key: UniqueKey(), profile: e)).toList();
  }

  List<Widget> queue = [];
  bool gathering = false;

  List<Widget> popAmountFromQueue(int amount) {
    int actualAmount = min(amount, queue.length);

    List<Widget> result = [];
    for (int i = 0; i < actualAmount; i++) {
      result.add(queue.removeAt(0));
    }

    return result;
  }

  Future<void> _gatherForQueue(int amount) async {
    gathering = true;
    final userIDs = await getRecommendedUserIDs(_authService.currentUser!.uid, amount);
    final users = await getUsers(userIDs);
    final widgets = constructWidgetsFromUserData(users);
    queue.addAll(widgets);
    gathering = false;
  }

  Future<List<Widget>> gather(int amount) async {
    if (queue.length <= queueSize && !gathering) {
      await _gatherForQueue(queueSize);
      //print("Done filling queue");
    }

    final result = popAmountFromQueue(amount);

    //print("Done gathering");
    return result;
  }
}
