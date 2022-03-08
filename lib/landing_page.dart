import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets.dart';
import 'package:project_seg/constants.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.1, 0.2, 1],
        colors: [
          // Color(0xFF827081),
          Color(0xFF00CFFF),
          Color(0xFF01B3E0),
          kPrimaryColour,
        ],
      )),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize:Size.fromHeight(0.1 * screenHeight) , // here the desired height
          child:AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // backgroundColor:  Colors.black45,
          systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, 
          ),
          title: const Text(
            'BESTIES',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          centerTitle: true,
          automaticallyImplyLeading: false
        ),),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text('LOGO'),
                SizedBox.fromSize(size: Size.fromHeight(0.5 * screenHeight)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 0.85 * screenWidth,
                    height: 0.08 * screenHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(" LOG IN"),
                      style: ElevatedButton.styleFrom(
                          primary: kLightBlue,
                          fixedSize: const Size(300, 100),
                          shadowColor: kSecondaryColour,
                          elevation: 12,
                          textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                ),
                // const SizedBox(height: 30),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: SizedBox(
                    width: 0.85 * screenWidth,
                    height: 0.08 * screenHeight,
                    child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text("SIGN UP"),
                    style: ElevatedButton.styleFrom(
                        primary: kWhiteColour,
                        onPrimary: kPrimaryColour,
                        fixedSize: const Size(300, 100),
                        shadowColor: kPrimaryColour,
                        elevation: 12,
                        textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                   )),
                 ),
              ]),
        ),
      ),
    );
  }
}
