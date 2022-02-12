import 'package:flutter/material.dart';
import 'nav_bar.dart';
import 'profile_container.dart';
import 'constants.dart';

// This method generates n containers to fill the PageView
void fillContainers(List<ProfileContainer> containers) {
  for (int i = 0; i < 5; i++) {
    containers.add(ProfileContainer());
  }
}

// For now only shows an AlertDialog
void likeProfile(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("You liked this profile!"),
        actions: [
          TextButton(
            child: const Text("Dismiss"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: FloatingActionButton(
              onPressed: () {
                likeProfile(context);
              },
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.thumb_up_off_alt_rounded,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: Constants.feedIconIndex,
      ),
    );
  }
}
