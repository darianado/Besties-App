import 'package:flutter/material.dart';

class SignUp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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