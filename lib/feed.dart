import 'package:flutter/material.dart';
import 'nav_bar.dart';
import 'profile_container.dart';
import 'profile_class.dart';
import 'constants.dart';

class Feed extends StatelessWidget {
  final List<ProfileContainer> containers = [
    ProfileContainer(profile: Profile(seed: 0)),
    ProfileContainer(profile: Profile(seed: 1)),
    ProfileContainer(profile: Profile(seed: 2)),
    ProfileContainer(profile: Profile(seed: 3)),
    ProfileContainer(profile: Profile(seed: 4)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        leading: const BackButton(
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          PageView(
            scrollDirection: Axis.vertical,
            children: containers,
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: kFeedIconIndex,
      ),
    );
  }
}
