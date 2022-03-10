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

    Future<List<ProfileContainer>> getContainers(String uid, int recs) async {
      List<ProfileContainer> containers =
          await FeedProfileManager.getProfileContainers(uid, recs);

      return containers;
    }

    double screenHeight = MediaQuery.of(context).size.height;

    final _userState = Provider.of<UserState>(context);

    return FutureBuilder(
      future: getContainers('KxeqzASITNRMdOOvCwGzCmnTJpF3', 5),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done /*&& snapshot.hasData*/) {
          return PageView(
            scrollDirection: Axis.vertical,
            children: snapshot.data as List<ProfileContainer>,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
