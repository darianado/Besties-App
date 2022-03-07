import 'package:flutter/material.dart';
import 'package:project_seg/Personal_information/edit_password.dart';
import 'package:project_seg/Personal_information/edit_preferences.dart';
import 'package:project_seg/Personal_information/edit_profile.dart';
import 'package:project_seg/Personal_information/profile_page.dart';
import 'package:project_seg/authenticator.dart';
import 'package:project_seg/recoverPassword.dart';
import 'package:project_seg/models/my_user.dart';
import 'package:project_seg/wrapper.dart';
import 'package:provider/provider.dart';
import 'Sign_Up/sign_up1.dart';
import 'Sign_Up/sign_up2.dart';
import 'Sign_Up/sign_up3.dart';
import 'Sign_Up/sign_up4.dart';
import 'log_in.dart';
import 'feed.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {


    return StreamProvider<MyUser?>.value(
      value: FirebaseAuthHelper().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryTextTheme: const TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.orange,
            displayColor: Colors.red,
          ),
        // Define the default brightness and colors.
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFFEFCFB),
        primaryColor: Color(0xFF0083A1),
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 25.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => Wrapper(),
          '/': (context) => SignUp1(),
          '/first': (context) => SignUp2(),
          '/signup3': (context) => SignUp3(),
          '/signup4': (context) => SignUp4(),
          '/feed': (context) => Feed(),
          '/login' : (context) => LogIn(),
          '/profile_page' : (context) => ProfilePage(),
          '/edit_profile' : (context) => EditProfile(),
          '/edit_preferences' : (context) => EditPreferences(),
          '/edit_password' : (context) => Edit_Password(),
          '/recover_password' : (context) => recoverPassword(),

        },
      )

    );
    
  }
}
