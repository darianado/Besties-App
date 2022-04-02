import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/services/feed_content_gatherer.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/states/recommendations_state.dart';
import 'package:project_seg/states/user_state.dart';

/// This class is responsible for managing, updating and displaying
/// the queue of recommended users.
///
/// The [FeedContentController] gets its [content] from the [FeedContentGatherer],
/// that is otherwise initialized with a [FeedLoadingSheet]. The [FeedContentGatherer]
/// then updates the [content] when the queue is finally loaded and is responsible
/// for removing, inserting and refreshing the [content].
class FeedContentController extends ChangeNotifier {
  final _desiredFeedContentLength = 5;
  final UserState userState;
  FeedContentGatherer? gatherer;

  List<Widget> content = [
    FeedLoadingSheet(
      key: UniqueKey(),
    ),
  ];

  FeedContentController({required this.userState});

  /// Initializes the [PageController].
  ///
  /// This method is responsible for adding a listener to the page [controller]
  /// and then initializing the [gatherer] to start listening for new [content].
  void assignController(PageController controller) {
    controller.addListener(() => pageChangeListener(controller));
    gatherer = FeedContentGatherer(
        userState: userState,
        onLikeComplete: (likedUser) {
          controller.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
          gatherer?.removeLiked();
        });
  }

  bool removalTriggered = false;

  /// Notifies all [FeedContentController] listeners of page changes, if any.
  ///
  /// The method also removes the second to last profile that has been scrolled off the screen.
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

  /// Removes the [ProfileContainer] at the front of the queue.
  void removeAtFront(int amount) {
    for (int i = 0; i < amount; i++) {
      content.removeAt(0);
    }
  }

  /// Removes all the [ProfileContainer]s from the queue.
  void removeAll() {
    content.removeWhere((element) => element.runtimeType != FeedLoadingSheet);
  }


  /// Inserts a [ProfileContainer] at the end of the queue.
  /// 
  /// [content] is only updated if its size goes below the [_desiredFeedContentLength].
  Future<void> insertAtEnd() async {
    if (_desiredFeedContentLength - 2 > (content.length - 1)) {
      final entries = await gatherer?.gather(_desiredFeedContentLength);
      if (entries != null) {
        content.addAll(entries);
      }
      moveLoadingScreenLast();
    }
  }

  /// Moves the [FeedLoadingSheet] to the end of the queue.
  void moveLoadingScreenLast() {
    final index = content.indexWhere(
        (Widget element) => element.runtimeType == FeedLoadingSheet);
    final loadingScreen = content.removeAt(index);
    content.add(loadingScreen);
  }

  /// Clears the [gatherer]'s queue and listens for new recommendations.
  void onFeedInitialized(FirestoreService firestoreService) {
    final RecommendationsState _recState = RecommendationsState(
        userState.user!.user!,
        firestoreService: firestoreService);

    _recState.addListener(() async {
      removeAll();
      if (!_recState.loadingRecommendations) {
        gatherer?.queue.clear();
        await insertAtEnd();
      }
      notifyListeners();
    });
  }

  /// Refreshes the [content].
  Future<void> refreshContent() async {
    removeAll();
    notifyListeners();
    await insertAtEnd();
    notifyListeners();
  }
}

/// A widget that displays a loading screen while the feed is being loaded.
class FeedLoadingSheet extends StatelessWidget {
  const FeedLoadingSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: leftRightPadding, right: leftRightPadding),
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
                        child: Lottie.asset('assets/lotties/searching.json',
                            fit: BoxFit.cover),
                      ),
                    ),
                    Text(
                      "Searching...",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                        "Give us a minute while we search for your next match."),
                    const SizedBox(height: 10),
                    const Text(
                        "If this is taking too long, try editing your preferences.")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
