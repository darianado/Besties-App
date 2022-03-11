import 'package:flutter/material.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/screens/home/profile/components/cached_image.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final _userState = Provider.of<UserState>(context);

    wrapWidget() {
      return Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: _userState.user?.userData?.interests.map<Widget>((e) => chip(e, kSecondaryColour)).toList() ?? []);
    }

    return Scaffold(
      backgroundColor: kWhiteColour,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 0.3 * screenHeight,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.65, 1],
                    colors: [kTertiaryColour, kLightBlue],
                  )),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35.0, right: 10.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: kWhiteColour,
                        ),
                        onPressed: () => context.pushNamed("edit_profile", params: {'page': 'profile'}),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120.0, bottom: 30.0),
                  child: Center(
                    child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      elevation: 20.0,
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: CachedImage(userId: _userState.user?.user?.uid),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                _userState.user?.userData?.fullName ?? "-",
                style: TextStyle(
                  color: kTertiaryColour,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.school_outlined,
                  color: kTertiaryColour,
                ),
              ),
              Text(
                _userState.user?.userData?.university ?? "-",
                style: const TextStyle(
                  fontSize: 30,
                  color: kTertiaryColour,
                ),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "${_userState.user?.userData?.age}",
                style: TextStyle(
                  fontSize: 20,
                  color: kTertiaryColour,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                _userState.user?.userData?.bio ?? "-",
                style: TextStyle(
                  fontSize: 20,
                  color: kTertiaryColour,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: wrapWidget(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
              child: SizedBox(
                width: 0.80 * screenWidth,
                height: 0.07 * screenHeight,
                child: ElevatedButton(
                  onPressed: () => context.pushNamed("edit_preferences", params: {'page': 'profile'}),
                  child: const Text(
                    "Edit preferences",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kTertiaryColour,
                    onPrimary: kWhiteColour,
                    shadowColor: kTertiaryColour,
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _userState.signOut(),
              child: Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }

  Widget chip(String label, Color color) {
    return Chip(
      labelPadding: EdgeInsets.all(5.0),
      label: Text(
        label[0].toUpperCase() + label.substring(1).toLowerCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(6.0),
    );
  }
}
