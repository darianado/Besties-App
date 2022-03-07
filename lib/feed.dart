import 'package:flutter/material.dart';
import 'package:project_seg/authenticator.dart';
import 'nav_bar.dart';
import 'profile_container.dart';
import 'profile_class.dart';
import 'constants.dart';
import 'package:project_seg/alerts.dart';


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

  final FirebaseAuthHelper _auth = FirebaseAuthHelper();

 _logoutAccount() async {
    final status = await _auth.logOut();
    if (status == null) {
      Navigator.pushNamed(context, '/landing');
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      showAlert(context, errorMsg);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        leading: const BackButton(
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          TextButton(
            child: const Text("Log out"),
            onPressed: () async {
              _logoutAccount(); 
            },
          )
        ],
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
