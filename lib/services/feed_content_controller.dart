import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/services/feed_content_gatherer.dart';

class FeedContentController extends ChangeNotifier {
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

      await insertAtEnd(1);
      notifyListeners();
    }
  }

  void removeAtFront(int amount) {
    for (int i = 0; i < amount; i++) {
      content.removeAt(0);
    }
  }

  Future<void> insertAtEnd(int amount) async {
    final lastElement = content.removeLast();
    content.addAll(await _gatherer.gather(amount));
    content.add(lastElement);
  }

  // Ensure notifyListeners() is not called immediately.
  void onFeedInitialized() async {
    await insertAtEnd(5);
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
