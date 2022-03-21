import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import '../../../models/profile_container.dart';
import 'package:project_seg/constants/colours.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Queue<ProfileContainer>? availableContainers = Queue();
  Queue<ProfileContainer> displayedContainers = Queue();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final _userState = Provider.of<UserState>(context);
    final uid = _userState.user?.user?.uid;

    if (uid != null) {
      return FutureBuilder(
        future: FirestoreService.getProfileContainers(uid, 1000),
        builder: (context, AsyncSnapshot<Queue<ProfileContainer>> snapshot) {
          availableContainers = snapshot.data;
          print(availableContainers!.length);

          if (availableContainers != null) {
            initialiseContainers(2);
            print(displayedContainers.length);
            return Container(
              color: kTertiaryColour,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // SizedBox(
                  //   height: 300,
                  //   width: 300,
                  //   child: Lottie.asset('assets/lotties/loading-dots.json'),
                  // ),
                  PageView(
                    scrollDirection: Axis.vertical,
                    children: displayedContainers.toList(),
                    onPageChanged: (p) => setState(
                      () {
                        updateContainerList(1);
                      },
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

  void initialiseContainers(int nOfContainers) {
    for (int i = 0; i < nOfContainers; i++) {
      displayedContainers.add(availableContainers!.removeFirst());
    }
  }

  void updateContainerList(int nOfContainers) async {
    for (int i = 0; i < nOfContainers; i++) {
      displayedContainers.add(availableContainers!.removeFirst());
    }

    displayedContainers.removeFirst();
    print("AvailableContainers: " + availableContainers!.length.toString());
    print("DisplayedContainers: " + displayedContainers.length.toString());
  }
}
