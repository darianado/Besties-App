import 'package:flutter/material.dart';

class Sign_Up4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Screen 4'),
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          child: Text('Go Back To Screen 3'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}