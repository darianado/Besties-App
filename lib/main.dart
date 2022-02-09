import 'package:flutter/material.dart';
import 'sign_up1.dart';
import 'sign_up2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Sign_Up1(),
        '/first': (context) => Sign_Up2(),
      },
    );
  }
}