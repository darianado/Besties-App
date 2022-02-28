import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Sign Up'),
      ),
      body:
         Center(
           child: Column(
              mainAxisAlignment: MainAxisAlignment.center ,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Text(
                    'LOGO'
                ),
                const SizedBox(height: 150),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/feed');
                  },
                  child: const Text(" LOG IN"),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/signup1');
                  },
                  child: const Text("SIGN UP"),
                ),
              ]
      ),
         ),
    );
  }
}

