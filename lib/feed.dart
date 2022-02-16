import 'package:flutter/material.dart';
import 'nav_bar.dart';
import 'profile_container.dart';
import 'profile_class.dart';
import 'constants.dart';

// This method generates n containers to fill the PageView
void fillContainers(List<ProfileContainer> containers) {
  for (int i = 0; i < 5; i++) {
    // Passes in a dummy profile
    containers.add(ProfileContainer(
      profile: const Profile(),
    ));
  }
}

class Feed extends StatelessWidget {
  final List<ProfileContainer> containers = [];
  @override
  Widget build(BuildContext context) {
    fillContainers(containers);

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
