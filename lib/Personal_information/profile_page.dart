import 'package:flutter/material.dart';
import 'package:project_seg/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit_profile');
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120.0, bottom: 30.0),
                  child: Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          AssetImage("assets/images/empty_profile_picture.jpg"),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Name',
                style: TextStyle(
                  color: kTertiaryColour,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.school_outlined,
                      color: kTertiaryColour,
                    ),
                  ),
                  Text(
                    'University',
                    style: const TextStyle(
                      fontSize: 30,
                      color: kTertiaryColour,
                    ),
                  ),
                ]
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "21",
                style: TextStyle(
                  fontSize: 20,
                  color: kTertiaryColour,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Bio",
                style: TextStyle(
                  fontSize: 20,
                  color: kTertiaryColour,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Preferences",
                style: TextStyle(
                  fontSize: 20,
                  color: kTertiaryColour,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
              child: SizedBox(
                width: 0.80 * screenWidth,
                height: 0.07 * screenHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit_preferences');
                  },
                  child: const Text("Edit preferences", style: TextStyle(
                    fontSize: 20,
                  ),),
                  style: ElevatedButton.styleFrom(
                    primary: kTertiaryColour,
                    onPrimary: kWhiteColour,
                    shadowColor: kTertiaryColour,
                    elevation: 12,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
