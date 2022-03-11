import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import '../../../models/profile_container.dart';
import '../../../services/feed_profile_manager.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final _userState = Provider.of<UserState>(context);

    return FutureBuilder(
      future: FeedProfileManager.getProfileContainers('oqcGC8SUkqX1FKvssZXwYrmaJFA3', 1),
      builder: (context, AsyncSnapshot<List<ProfileContainer>?> snapshot) {
        List<ProfileContainer>? snapshotData = snapshot.data;

        if (snapshotData == null) {

          return PageView(
            scrollDirection: Axis.vertical,
            children: snapshotData as List<ProfileContainer>,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
