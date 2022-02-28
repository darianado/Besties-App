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
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              // Color(0xFF827081),
              Color(0xFF31081F),
              Color(0xFFDCE0D9)
            ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black45,
          title: const Text('Sign Up'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('LOGO'),
                const SizedBox(height: 150),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(" LOG IN"),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFFCC8B86),
                      fixedSize: const Size(300, 100),
                      shadowColor: Color(0xFF7A306C),
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text("SIGN UP"),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF7A306C),
                      fixedSize: const Size(300, 100),
                      shadowColor: Color(0xFFCC8B86),
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                ),
              ]),
        ),
      ),
    );
  }
}
