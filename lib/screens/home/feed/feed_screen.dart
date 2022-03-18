import 'package:flutter/material.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import '../../../models/profile_container.dart';

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
    final uid = _userState.user?.user?.uid;
    
    if (uid != null) {
      return FutureBuilder(
        future: FirestoreService.getProfileContainers(uid, 1),
        builder: (context, AsyncSnapshot<List<ProfileContainer>> snapshot) {
          List<ProfileContainer>? snapshotData = snapshot.data;

          if (snapshotData != null) {
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
                    children: snapshotData,
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: kTertiaryColour,));
          }
        },
      );
    } else {
      return const CircularProgressIndicator(color: kTertiaryColour,);
    }
  }
}
