import 'package:flutter/material.dart';
import 'package:project_seg/landingPage.dart';
import 'package:project_seg/profile_page.dart';
import 'sign_up1.dart';
import 'sign_up2.dart';
import 'sign_up3.dart';
import 'sign_up4.dart';
import 'landingPage.dart';
import 'log_in.dart';
import 'feed.dart';
import 'profile_page.dart';
import 'edit_profile.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/landing',
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


      },
    );
  }
}
