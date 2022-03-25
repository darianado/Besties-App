import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:project_seg/services/user_state.dart';
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

  static PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  static void animateToTop() {
    controller.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOutCirc);
  }

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

/// The State for the [FeedScreen] widget.
class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();

    final _userState = Provider.of<UserState>(context, listen: false);
    final _feedContent =
        Provider.of<FeedContentController>(context, listen: false);
    _feedContent.onFeedInitialized();
    _feedContent.assignController(FeedScreen.controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _feedContentController = Provider.of<FeedContentController>(context);

    print(
        "Rebuilding. There are ${_feedContentController.content.length} elements in feed");

    return Container(
      color: tertiaryColour,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          RefreshIndicator(
            displacement: MediaQuery.of(context).padding.top,
            onRefresh: () => refreshProfileContainers(_feedContentController),
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
              padding: const EdgeInsets.only(right: leftRightPadding),
              child: Container(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: secondaryColour,
                    blurRadius: 55.0,
                  ),
                ]),
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: whiteColour,
                    size: 30,
                  ),
                  onPressed: () => context.pushNamed(editPreferencesScreenName,
                      params: {pageParameterKey: feedScreenName}),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Refreshes the profiles by updating the [FutureBuilder]'s future.
  Future<void> refreshProfileContainers(
      FeedContentController _feedContentController) async {
    await Future.delayed(const Duration(milliseconds: 400));
    FeedScreen.controller.jumpToPage(0);
    await _feedContentController.refreshContent();
  }
}

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);

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
