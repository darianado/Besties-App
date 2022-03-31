import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/home/feed/components/profile_container.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:project_seg/utility/helpers.dart';

/// A class responsible for keeping a local queue
/// of recommended users for the feed. The purpose is to
/// avoid continuously fetching small amounts of users, but instead
/// download batches of users which can then be fetched faster
/// by the [FeedContentController].
class FeedContentGatherer {
  final int queueSize = 10; // Determines the threshold where the app will fetch users from the backend.
  final int batchSize = 10; // Determines how many splits we make when fetching profiles using array of userIDs
  final Function(UserData)? onLikeComplete;

  final UserState userState;

  /// Constructor for the [FeedContentGatherer].
  /// A [UserState] is required to know which user to fetch recommendations for.
  /// An optional [Function] can be provided, in which that will be passed to
  /// any [ProfileContainer]s created in this class.
  FeedContentGatherer({required this.userState, this.onLikeComplete});

  /// Function which queries the Firebase Functions backend to retrieve a list
  /// of user ID's of maximum [amount] in length.
  ///
  /// If this method is called from a testing context (I.e., the [UserState] this class
  /// was instantiated with relies on a [FakeFirebaseFirestore] object), a dummy response
  /// will be provided. This is because Firebase Functions are unavailable from a testing
  /// context.
  Future<List<String>> getRecommendedUserIDs(String userID, int amount) async {
    List<String> results = [];

    // HTTP clients are unavailable in Flutter tests. We must catch this, and provide a dummy response.
    if (userState.firestoreService is FakeFirebaseFirestore) {
      print("Making a response");
      final appRecommendationsTestResponse = {
        "status": 200,
        "data": [
          "abc123",
          "acb321",
        ],
      };
      results = appRecommendationsTestResponse['data'] as List<String>;
    } else {
      HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'europe-west2').httpsCallable('requestRecommendations');
      final resp = await callable.call(<String, dynamic>{
        'uid': userID,
        'recs': amount,
      });

      results = List<String>.from(resp.data['data']);
    }

    results.removeWhere((element) => userState.user?.userData?.likes?.contains(element) ?? false);
    return results;
  }

  /// Retrieves a List of [OtherUser] objects which are representations of the [userIDs] given,
  /// and includes a "liked" parameter, indicating whether the currently logged in user already
  /// has liked the given person.
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

  /// Constructs a list of [ProfileContainer] from a list of [OtherUser]. The [onLikeComplete]
  /// parameter is passed directly to the [ProfileContainer] to be called when a like has been made.
  List<ProfileContainer> constructWidgetsFromUserData(List<OtherUser> userDataLst, Function onLikeComplete) {
    return userDataLst
        .map((e) => ProfileContainer(
              key: UniqueKey(),
              profile: e.userData,
              liked: e.liked,
              onLikeComplete: () => onLikeComplete(e.userData),
            ))
        .toList();
  }

  List<ProfileContainer> queue = [];
  bool gathering = false;

  /// Removes and returns up to [amount] number of Widgets from the queue.
  List<ProfileContainer> popAmountFromQueue(int amount) {
    int actualAmount = min(amount, queue.length);

    List<ProfileContainer> result = [];
    for (int i = 0; i < actualAmount; i++) {
      result.add(queue.removeAt(0));
    }

    return result;
  }

  /// Asynchronously gathers up to [amount] of new users for the queue.
  /// Also sets the [gathering] flag to true while doing so.
  Future<void> _gatherForQueue(int amount) async {
    gathering = true;
    final userIDs = await getRecommendedUserIDs(userState.user!.user!.uid, amount);
    final users = await getUsers(userIDs);
    final widgets = constructWidgetsFromUserData(users, onLikeComplete ?? () {});
    queue.addAll(widgets);
    gathering = false;
  }

  /// Removes and returns up to [amount] number of widgets from the queue.
  /// Also checks if the queue should be filled again, and potentially starts
  /// gathering new users.
  Future<List<Widget>> gather(int amount) async {
    if (queue.length <= queueSize && !gathering) {
      await _gatherForQueue(queueSize);
    }

    return popAmountFromQueue(amount);
  }

  /// Removes any [ProfileContainer] from the queue that represents a user
  /// which the currently logged in user has liked.
  void removeLiked() {
    queue.removeWhere((ProfileContainer element) => userState.user?.userData?.likes?.contains(element.profile.uid) ?? false);
  }

  /// Removes all entries in the queue.
  void removeAll() {
    queue.clear();
  }
}
