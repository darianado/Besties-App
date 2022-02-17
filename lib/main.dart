import 'package:flutter/material.dart';
import 'sign_up1.dart';
import 'sign_up2.dart';
import 'sign_up3.dart';
import 'sign_up4.dart';
import 'log_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/': (context) => Sign_Up1(),
        '/first': (context) => Sign_Up2(),
        '/signup3' : (context) => Sign_Up3(),
        '/signup4' : (context) => Sign_Up4(),
        '/login' : (context) => Log_In(),
      },
    );
  }
}