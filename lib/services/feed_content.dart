import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FeedContent extends ChangeNotifier {
  List<Widget> content = [
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "0",
    ),
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "1",
    ),
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "2",
    ),
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "3",
    ),
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "4",
    ),
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "5",
    ),
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "6",
    ),
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "7",
    ),
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "8",
    ),
    FeedLoadingSheet(
      key: UniqueKey(),
      label: "9",
    ),
  ];

  FeedContent._privateConstructor();
  static final FeedContent _instance = FeedContent._privateConstructor();
  static FeedContent get instance => _instance;

  int? oldIndex;

  void assignController(PageController controller) {
    controller.addListener(() {
      if (controller.page! >= 2) {
        content.removeAt(0);
        notifyListeners();
        controller.jumpToPage(1);
      }
    });
  }

  // Ensure notifyListeners() is not called immediately.
  void onFeedInitialized() async {
    // Start the whole thing
    /*
    await Future.delayed(const Duration(milliseconds: 2000));

    content.add(FeedLoadingSheet(
      key: UniqueKey(),
    ));
    notifyListeners();
    */
  }
}

class FeedLoadingSheet extends StatelessWidget {
  final label;
  const FeedLoadingSheet({Key? key, required this.label}) : super(key: key);

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
            Text(label),
          ],
        ),
      ),
    );
  }
}
