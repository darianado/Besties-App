import 'package:flutter/material.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import '../../../models/profile_class.dart';
import '../../../models/profile_container.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
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
