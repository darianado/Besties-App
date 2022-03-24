import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';

/// The screen that displays profiles to the user.
///
/// The profiles are arranged in a vertical [PageView]
/// and are asynchronously fetched prior to building the [Widget].
/// A [CircularProgressIndicator] is returned for the whole duration of
/// the async method.
class FeedScreen extends StatefulWidget {
  FeedScreen({Key? key}) : super(key: key);

  static PageController controller = PageController(viewportFraction: 1, keepPage: true);

  static void animateToTop() {
    controller.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

/// The State for the [FeedScreen] widget.
class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();

    final _feedContent = Provider.of<FeedContentController>(context, listen: false);
    _feedContent.onFeedInitialized();
    _feedContent.assignController(FeedScreen.controller);
  }

  @override
  Widget build(BuildContext context) {
    final _feedContentController = Provider.of<FeedContentController>(context);

    //print("Rebuilding. There are ${_feedContentController.content.length} elements in feed");

    return Container(
      color: kTertiaryColour,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          RefreshIndicator(
            displacement: MediaQuery.of(context).padding.top,
            onRefresh: () => refreshProfileContainers(),
            child: PageView(
              physics: const CustomPageViewScrollPhysics(),
              controller: FeedScreen.controller,
              scrollDirection: Axis.vertical,
              children: List<Widget>.of(_feedContentController.content),
            ),
          ),
          (Platform.isIOS)
              ? ColorfulSafeArea(
                  overflowRules: OverflowRules.all(true),
                  color: Colors.white.withOpacity(0.5),
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(),
                )
              : Container(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: leftRightPadding),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () => context.pushNamed(editPreferencesScreenName, params: {pageParameterKey: feedScreenName}),
                backgroundColor: kTertiaryColour,
                child: Icon(
                  Icons.menu,
                  color: kWhiteColour,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    /*
    final _userState = Provider.of<UserState>(context);
    final uid = _userState.user?.user?.uid;

    if (uid != null) {
      return FutureBuilder(
        future: _future,
        builder: (context, AsyncSnapshot<Queue<ProfileContainer>> snapshot) {
          displayedContainers = snapshot.data;

          if (displayedContainers != null) {
            return Container(
              color: kTertiaryColour,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  RefreshIndicator(
                    onRefresh: () => refreshProfileContainers(uid, recs),
                    child: PageView(
                      controller: FeedScreen.controller,
                      scrollDirection: Axis.vertical,
                      children: displayedContainers!.toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: leftRightPadding),
                    child: FloatingActionButton(
                      heroTag: null,
                      onPressed: () => context.pushNamed(editPreferencesScreenName, params: {pageParameterKey: feedScreenName}),
                      backgroundColor: kTertiaryColour,
                      child: Icon(
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
    */
  }

  /// Refreshes the profiles by updating the [FutureBuilder]'s future.
  Future<void> refreshProfileContainers() async {
    await Future.delayed(const Duration(milliseconds: 400));

    await Future.delayed(const Duration(milliseconds: 400));
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 50,
        damping: 0.7,
      );
}
