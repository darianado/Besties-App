import 'package:flutter/material.dart';
import 'package:project_seg/sign_up1.dart';
import 'sign_up1.dart';

class SignUp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Screen 4'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go Back To Screen 3'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}