import 'package:flutter/material.dart';
import 'sign_up1.dart';
import 'sign_up2.dart';
import 'sign_up3.dart';
import 'sign_up4.dart';
import 'feed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Sign_Up1(),
        '/first': (context) => Feed(),
        '/signup2': (context) => Sign_Up2(),
        '/signup3' : (context) => Sign_Up3(),
        '/signup4' : (context) => Sign_Up4(),
        '/feed' : (context) => Feed(),

      },
    );
  }
}