import 'package:flutter/material.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:cloud_functions/cloud_functions.dart';

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

  Future<void> requestRecommendations() async {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'https://europe-west2-seg-djangoals.cloudfunctions.net/testNoParam');
    dynamic resp = await callable();
    print("result: ${resp.data}");
  }

  // Future<void> requestRecommendations() async {
  //   HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
  //       'https://europe-west2-seg-djangoals.cloudfunctions.net/requestRecommendations');
  //   final resp = await callable.call(<String, dynamic>{
  //     'userId': 'emqRhsblgvb52w4bP6houj4BhGv2',
  //     'recs': 10,
  //   });
  //   print("result: ${resp.data}");
  // }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    requestRecommendations();

    final _userState = Provider.of<UserState>(context);

    return PageView(
      scrollDirection: Axis.vertical,
      children: containers,
    );
  }
}
