import 'package:flutter/material.dart';
import 'sign_up1.dart';

class SignUp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 4'),
        leading: const BackButton(
          color: Colors.white,
        ),
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