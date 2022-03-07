import 'package:flutter/material.dart';
import 'package:project_seg/services/UserState.dart';
import 'package:provider/provider.dart';

import 'profile_class.dart';
import 'profile_container.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final List<ProfileContainer> containers = [
    ProfileContainer(profile: Profile(seed: 0)),
    ProfileContainer(profile: Profile(seed: 1)),
    ProfileContainer(profile: Profile(seed: 2)),
    ProfileContainer(profile: Profile(seed: 3)),
    ProfileContainer(profile: Profile(seed: 4)),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final _userState = Provider.of<UserState>(context);

    return PageView(
      scrollDirection: Axis.vertical,
      children: containers,
    );
  }
}
