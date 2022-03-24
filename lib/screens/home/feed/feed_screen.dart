import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
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
  final int recs = 10;
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
              color: tertiaryColour,
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
                    padding:
                        const EdgeInsets.only(top: 48, right: leftRightPadding),
                    child: Container(
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(color: secondaryColour, blurRadius: 60.0),
                      ]),
                      child: IconButton(
                        onPressed: () => context.pushNamed(
                            editPreferencesScreenName,
                            params: {pageParameterKey: feedScreenName}),
                        icon: const Icon(
                          Icons.menu,
                          color: whiteColour,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: tertiaryColour,
            ));
          }
        },
      );
    } else {
      return const CircularProgressIndicator(
        color: tertiaryColour,
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
