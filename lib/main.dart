import 'package:flutter/material.dart';
import 'package:project_seg/landingPage.dart';
import 'package:project_seg/Personal_information/profile_page.dart';
import 'Sign_Up/sign_up1.dart';
import 'Sign_Up/sign_up2.dart';
import 'Sign_Up/sign_up3.dart';
import 'Sign_Up/sign_up4.dart';
import 'landingPage.dart';
import 'log_in.dart';
import 'feed.dart';
import 'Personal_information/profile_page.dart';
import 'Personal_information/edit_profile.dart';
import 'Personal_information/edit_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/signup1',
      routes: {
        '/landing': (context) => LandingPage(),
        '/signup1': (context) => SignUp1(),
        '/signup2': (context) => SignUp2(),
        '/signup3': (context) => SignUp3(),
        '/signup4': (context) => SignUp4(),
        '/feed': (context) => Feed(),
        '/login' : (context) => Log_In(),
        '/profile_page' : (context) => Profile_Page(),
        '/edit_profile' : (context) => EditProfile(),
        '/edit_preferences' : (context) => EditPrefrences(),


      },
    );
  }
}
