import 'dart:collection';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/constants/constant.dart';
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
  Future<Queue<ProfileContainer>>? _future;
  final int recs = 100;
  double? currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();

    final FirebaseAuth auth = FirebaseAuth.instance;
    final String uid = auth.currentUser!.uid;

    _future = FirestoreService.getProfileContainers(uid, recs);

    FeedScreen.controller.addListener(() {
      setState(() {
        currentPageValue = FeedScreen.controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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

  /// Refreshes the profiles by updating the [FutureBuilder]'s future.
  Future<void> refreshProfileContainers(String uid, int recs) async {
    await Future.delayed(const Duration(milliseconds: 400));

    setState(() {
      _future = FirestoreService.getProfileContainers(uid, recs);
    });
    await Future.delayed(const Duration(milliseconds: 400));
  }
}
