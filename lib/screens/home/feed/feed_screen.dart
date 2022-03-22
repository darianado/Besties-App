import 'dart:collection';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

import 'package:flutter/material.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import '../../../models/profile_container.dart';
import 'package:project_seg/constants/colours.dart';

/// The screen that displays profiles to the user.
///
/// The profiles are arranged in a vertical [PageView]
/// and are asynchronously fetched prior to building the [Widget].
/// A [CircularProgressIndicator] is returned for the whole duration of
/// the async method.
class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  static PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  static void animateToTop() {
    controller.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

/// The State for the [FeedScreen] widget.
class _FeedScreenState extends State<FeedScreen> {
  Queue<ProfileContainer>? displayedContainers = Queue();

  double? currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    FeedScreen.controller.addListener(() {
      setState(() {
        currentPageValue = FeedScreen.controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final _userState = Provider.of<UserState>(context);
    final uid = _userState.user?.user?.uid;

    if (uid != null) {
      return FutureBuilder(
        future: FirestoreService.getProfileContainers(uid, 1000),
        builder: (context, AsyncSnapshot<Queue<ProfileContainer>> snapshot) {
          displayedContainers = snapshot.data;

          if (displayedContainers != null) {
            return Container(
              color: kTertiaryColour,
              child: Stack(
                alignment: Alignment.topRight,
                children: [

                  RefreshIndicator(
                    onRefresh: () => refreshProfileContainers(uid, 1000),
                    child: PageView(
                      controller: FeedScreen.controller,
                      scrollDirection: Axis.vertical,
                      children: displayedContainers!.toList(),
                    ),
                    // TODO: Custom Refresh Indicator not setup
                    // builder: (
                    //   BuildContext context,
                    //   Widget child,
                    //   IndicatorController controller,
                    // ) {
                    //   // TODO: Implement your own refresh indicator
                    //   return Stack(
                    //     alignment: Alignment.topCenter,
                    //     children: <Widget>[
                    //       AnimatedBuilder(
                    //         animation: controller,
                    //         builder: (BuildContext context, _) {
                    //           /// This part will be rebuild on every controller change
                    //           return CircularProgressIndicator();
                    //         },
                    //       ),
                    //       child,
                    //     ],
                    //   );
                    // }),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 25, 0),
                    child: GestureDetector(
                      onTap: () => {},
                      child: const Icon(
                        Icons.menu,
                        color: kWhiteColour,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: kTertiaryColour,
            ));
          }
        },
      );
    } else {
      return const CircularProgressIndicator(
        color: kTertiaryColour,
      );
    }
  }

  /// Refreshes the list of displayed profiles. TODO: NOT WORKING AS OF YET
  Future<void> refreshProfileContainers(uid, recs) async {
    Queue<ProfileContainer>? newContainers =
        await FirestoreService.getProfileContainers(uid, 3);

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      displayedContainers = newContainers;
      print(displayedContainers!.length);
    });
  }
}
