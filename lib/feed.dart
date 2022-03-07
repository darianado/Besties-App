import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_seg/authenticator.dart';
import 'nav_bar.dart';
import 'profile_container.dart';
import 'profile_class.dart';
import 'constants.dart';
import 'package:project_seg/alerts.dart';

class Feed extends StatefulWidget {
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
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,

      // TO DO: appbar and logout should be removed from feed
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.06 * screenHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          // title: const Text('Feed', style: TextStyle(color: kSecondaryColour)),
          // centerTitle: true,
          actions: <Widget>[
            IconButton(
              // TO DO: log out should be move to profile or edit profile page (not necessary for feed)
              icon: const Icon(Icons.logout_outlined),
              color: kWhiteColour,
              onPressed: () async {
                _logoutAccount();
              },
            )
          ],
        ),
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
