import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/home/feed/components/profile_container.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/user_state.dart';

class FeedContentGatherer extends ChangeNotifier {
  final int queueSize = 10; // Determines the threshold where the app will fetch users from the backend.
  final int batchSize = 10; // Determines how many splits we make when fetching profiles using array of userIDs
  final Function(UserData)? onLikeComplete;

  final UserState userState;

  FeedContentGatherer({required this.userState, this.onLikeComplete});

  // Write some insurance in case this fails or times out.
  Future<List<String>> getRecommendedUserIDs(String userID, int amount) async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'europe-west2').httpsCallable('requestRecommendations');
    final resp = await callable.call(<String, dynamic>{
      'uid': userID,
      'recs': amount,
    });

    //print("Received this response: ${resp.data}");

    final result = List<String>.from(resp.data['data']);

    result.removeWhere((element) => userState.user?.userData?.likes?.contains(element) ?? false);

    //await Future.delayed(Duration(seconds: 12));

    return result;
  }

  List<List<String>> split(List<String> lst, int size) {
    List<List<String>> results = [];

    for (var i = 0; i < lst.length; i += size) {
      final end = (i + size < lst.length) ? i + size : lst.length;
      results.add(lst.sublist(i, end));
    }

    return results;
  }

  Future<List<OtherUser>> getUsers(List<String> userIDs) async {
    List<List<String>> splitUserIDs = split(userIDs, batchSize);

    List<OtherUser> results = [];

    for (int si = 0; si < splitUserIDs.length; si++) {
      List<String> slice = splitUserIDs[si];

      final snapshot = await FirebaseFirestore.instance.collection("users").where(FieldPath.documentId, whereIn: slice).get();
      results.addAll(
        snapshot.docs.map((doc) {
          final userData = UserData.fromSnapshot(doc);
          return OtherUser(liked: false, userData: userData);
        }).toList(),
      );
    }

    return results;
  }

  List<ProfileContainer> constructWidgetsFromUserData(List<OtherUser> userDataLst, Function onLikeComplete) {
    return userDataLst
        .map((e) => ProfileContainer(
              key: UniqueKey(),
              profile: e,
              onLikeComplete: () => onLikeComplete(e.userData),
            ))
        .toList();
  }

  List<ProfileContainer> queue = [];
  bool gathering = false;

  List<ProfileContainer> popAmountFromQueue(int amount) {
    int actualAmount = min(amount, queue.length);

    List<ProfileContainer> result = [];
    for (int i = 0; i < actualAmount; i++) {
      result.add(queue.removeAt(0));
    }

    return result;
  }

  Future<void> _gatherForQueue(int amount) async {
    gathering = true;
    final userIDs = await getRecommendedUserIDs(userState.user!.user!.uid, amount);
    final users = await getUsers(userIDs);
    final widgets = constructWidgetsFromUserData(users, onLikeComplete ?? () {});
    queue.addAll(widgets);
    //print("Queue: ${queue.length}");
    gathering = false;
  }

  Future<List<Widget>> gather(int amount) async {
    if (queue.length <= queueSize && !gathering) {
      await _gatherForQueue(queueSize);
    }

    return popAmountFromQueue(amount);
  }

  void removeLiked() {
    queue.removeWhere((ProfileContainer element) => userState.user?.userData?.likes?.contains(element.profile.userData.uid) ?? false);
  }

  void removeAll() {
    queue.clear();
  }
}
