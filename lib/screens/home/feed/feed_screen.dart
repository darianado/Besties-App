import 'dart:ui';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:provider/provider.dart';

/// A widget that displays a list of widgets in a vertical [PageView].
class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  static PageController controller =
      PageController(viewportFraction: 1, keepPage: true);

  static void animateToTop() {
    controller.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOutCirc);
  }

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();

    final _feedContent =
        Provider.of<FeedContentController>(context, listen: false);
    final _firestoreService =
        Provider.of<FirestoreService>(context, listen: false);
    _feedContent.onFeedInitialized(_firestoreService);
    _feedContent.assignController(FeedScreen.controller);
  }

  @override
  Widget build(BuildContext context) {
    final _feedContentController = Provider.of<FeedContentController>(context);

    return Stack(
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
        ColorfulSafeArea(
          overflowRules: const OverflowRules.all(true),
          color: Colors.white.withOpacity(0.5),
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: leftRightPadding, right: leftRightPadding),
            child: Container(
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: secondaryColour,
                  blurRadius: 55.0,
                ),
              ]),
              child: IconButton(
                icon: const Icon(
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
    );
  }

  /// Refreshes the profile containers displayed in the [FeedScreen].
  Future<void> refreshProfileContainers(
      FeedContentController _feedContentController) async {
    await Future.delayed(const Duration(milliseconds: 400));
    FeedScreen.controller.jumpToPage(0);
    await _feedContentController.refreshContent();
  }
}


/// A custom [ScrollPhysics] for the [PageView] in the [FeedScreen].
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
