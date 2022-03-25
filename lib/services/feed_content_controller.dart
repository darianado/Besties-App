import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/ActiveUser.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/feed_content_gatherer.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/recommendations_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class FeedContentController extends ChangeNotifier {
  final _desiredFeedContentLength = 5;

  List<Widget> content = [
    FeedLoadingSheet(
      key: UniqueKey(),
    ),
  ];

  FeedContentController._privateConstructor();
  static final FeedContentController _instance = FeedContentController._privateConstructor();
  static FeedContentController get instance => _instance;

  FeedContentGatherer? _gatherer;
  final FirestoreService _firestoreService = FirestoreService.instance;

  void assignController(PageController controller) {
    controller.addListener(() => pageChangeListener(controller));
    _gatherer = FeedContentGatherer(onLikeComplete: (likedUser) {
      controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
      _gatherer?.removeLiked();
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
      print("Requesting new content");
      final entries = await _gatherer?.gather(_desiredFeedContentLength);
      if (entries != null) content.addAll(entries);
      moveLoadingScreenLast();
    }
    print("Content: ${(content.length - 1)}");
  }

  void moveLoadingScreenLast() {
    final index = content.indexWhere((Widget element) => element.runtimeType == FeedLoadingSheet);
    final loadingScreen = content.removeAt(index);
    content.add(loadingScreen);
  }

  void onFeedInitialized() {
    final AuthService _authService = AuthService.instance;
    final RecommendationsState _recState = RecommendationsState(_authService.currentUser!);

    _recState.addListener(() async {
      //print("Queue changed!");
      print(_recState.currentQueueID);
      removeAll();
      if (!_recState.loadingRecommendations) {
        _gatherer?.removeAll();
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
                    child: Container(
                      width: double.infinity,
                      child: Lottie.asset('assets/lotties/searching.json', fit: BoxFit.cover),
                    ),
                  ),
                  Text(
                    "Searching...",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Give us a minute while we search for your next match."),
                  SizedBox(
                    height: 10,
                  ),
                  Text("If this is taking too long, try editing your preferences.")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
