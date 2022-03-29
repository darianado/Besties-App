import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/services/feed_content_gatherer.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/recommendations_state.dart';
import 'package:project_seg/services/user_state.dart';

class FeedContentController extends ChangeNotifier {
  final _desiredFeedContentLength = 5;
  final UserState userState;
  FeedContentGatherer gatherer;

  List<Widget> content = [
    FeedLoadingSheet(
      key: UniqueKey(),
    ),
  ];

  FeedContentController({required this.userState, required this.gatherer});

  void assignController(PageController controller) {
    controller.addListener(() => pageChangeListener(controller));
    gatherer = FeedContentGatherer(
        userState: userState,
        onLikeComplete: (likedUser) {
          controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
          gatherer.removeLiked();
        });
  }

  bool removalTriggered = false;

  void pageChangeListener(PageController controller) async {
    double? page = controller.page;

    if (page != null && page >= 1.65) {
      removalTriggered = true;
    }

    if (page != null && (page == 1 || page >= 2) && removalTriggered) {
      removeAtFront(1);
      removalTriggered = false;
      notifyListeners();
      controller.jumpToPage(page.toInt() - 1);

      await insertAtEnd();
      notifyListeners();
    }
  }

  void removeAtFront(int amount) {
    for (int i = 0; i < amount; i++) {
      content.removeAt(0);
    }
  }

  void removeAll() {
    content.removeWhere((element) => element.runtimeType != FeedLoadingSheet);
  }

  Future<void> insertAtEnd() async {
    if (_desiredFeedContentLength - 2 > (content.length - 1)) {
      //print("Requesting new content");
      final entries = await gatherer.gather(_desiredFeedContentLength);
      content.addAll(entries);
      moveLoadingScreenLast();
    }
    //print("Content: ${(content.length - 1)}");
  }

  void moveLoadingScreenLast() {
    final index = content.indexWhere((Widget element) => element.runtimeType == FeedLoadingSheet);
    final loadingScreen = content.removeAt(index);
    content.add(loadingScreen);
  }

  void onFeedInitialized(FirestoreService firestoreService) {
    final RecommendationsState _recState = RecommendationsState(userState.user!.user!, firestoreService: firestoreService);

    _recState.addListener(() async {
      //print("Queue changed!");
      //print(_recState.currentQueueID);
      removeAll();
      if (!_recState.loadingRecommendations) {
        gatherer.removeAll();
        await insertAtEnd();
      }
      notifyListeners();
    });
  }

  Future<void> refreshContent() async {
    removeAll();
    notifyListeners();
    await insertAtEnd();
    notifyListeners();
  }
}

class FeedLoadingSheet extends StatelessWidget {
  const FeedLoadingSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: leftRightPadding, right: leftRightPadding),
                child: Transform.scale(
                  scale: 4,
                  child: SizedBox(
                    height: 48,
                    child: Lottie.asset("assets/lotties/signal.json"),
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: SizedBox(
                      width: double.infinity,
                      child: Lottie.asset('assets/lotties/searching.json', fit: BoxFit.cover),
                    ),
                  ),
                  Text(
                    "Searching...",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 20),
                  const Text("Give us a minute while we search for your next match."),
                  const SizedBox(height: 10),
                  const Text("If this is taking too long, try editing your preferences.")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
