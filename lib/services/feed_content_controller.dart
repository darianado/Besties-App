import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/services/feed_content_gatherer.dart';

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

  FeedContentGatherer _gatherer = FeedContentGatherer.instance;

  void assignController(PageController controller) {
    controller.addListener(() => pageChangeListener(controller));
  }

  void pageChangeListener(PageController controller) async {
    double? page = controller.page;

    if (page != null && page.floor() >= 2) {
      removeAtFront(1);
      notifyListeners();
      controller.jumpToPage(1);

      await insertAtEnd();
      notifyListeners();
    }
  }

  void removeAtFront(int amount) {
    for (int i = 0; i < amount; i++) {
      content.removeAt(0);
    }
  }

  Future<void> insertAtEnd() async {
    if (_desiredFeedContentLength > (content.length - 1)) {
      final entries = await _gatherer.gather(_desiredFeedContentLength);
      final beforeLength = content.length;
      content.addAll(entries);
      print("Content: ${beforeLength} + ${entries.length} = ${content.length}");
      moveLoadingScreenLast();
    }
  }

  void moveLoadingScreenLast() {
    final index = content.indexWhere((Widget element) => element.runtimeType == FeedLoadingSheet);
    final loadingScreen = content.removeAt(index);
    content.add(loadingScreen);
  }

  // Ensure notifyListeners() is not called immediately.
  void onFeedInitialized() async {
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
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Text("Give us a minute while we search for your next match..."),
          ],
        ),
      ),
    );
  }
}
