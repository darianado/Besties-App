import 'package:flutter/material.dart';
import 'package:project_seg/services/UserState.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage("assets/images/empty_profile_picture.jpg"),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                ((_userState.user?.userData != null) ? _userState.user!.userData!.firstName : "-"),
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Age",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Bio",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Preferences",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_profile');
                    },
                    child: const Text("EDIT YOUR PROFILE"),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_preferences');
                    },
                    child: const Text("EDIT PREFRENCES"),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _userState.signOut(),
                child: const Text("Sign out"),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
