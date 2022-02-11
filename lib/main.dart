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
        // TODO: Route changed for testing purposes 
        // Revert before merging to main
        // '/': (context) => Sign_Up2(),
        '/first': (context) => Feed(),
        '/signup3' : (context) => Sign_Up3(),
        '/signup4' : (context) => Sign_Up4(),
      },
    );
  }
}