import 'package:flutter/material.dart';
import 'sign_up1.dart';
import 'sign_up2.dart';
import 'sign_up3.dart';
import 'sign_up4.dart';
import 'log_in.dart';
import 'feed.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   
      initialRoute: '/first',
      routes: {
        '/': (context) => SignUp1(),
        '/first': (context) => SignUp2(),
        '/signup3': (context) => SignUp3(),
        '/signup4': (context) => SignUp4(),
        '/feed': (context) => Feed(),
        '/login' : (context) => Log_In(),

      },
    );
  }
}
