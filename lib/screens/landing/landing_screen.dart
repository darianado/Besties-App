import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_seg/constants/textStyles.dart';
import '../../constants/borders.dart';
import '../../constants/colours.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
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
          kActiveCardColor,
          kSecondColourLanding,
          kShadowLanding,
        ],
      )),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.1 * screenHeight), // here the desired height
          child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              // backgroundColor:  Colors.black45,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ),
              title: const Text(
                'BESTIES',
                style: kLandingPageTitleStyle,
              ),
              centerTitle: true,
              automaticallyImplyLeading: false),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
            const Text('LOGO'),
            SizedBox.fromSize(size: Size.fromHeight(0.5 * screenHeight)),
            SizedBox(
              width: 0.85 * screenWidth,
              height: 0.08 * screenHeight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(" LOG IN"),
                style: ElevatedButton.styleFrom(
                    primary: kPrimaryColourLanding,
                    fixedSize: const Size(300, 100),
                    shadowColor: kShadowLanding,
                    elevation: 12,
                    textStyle: kLandingPageButtonsStyle,
                    shape: kRoundedRectangulareBorder50),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
                width: 0.85 * screenWidth,
                height: 0.08 * screenHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text("SIGN UP"),
                  style: ElevatedButton.styleFrom(
                      primary: kWhiteColour,
                      onPrimary: kShadowLanding,
                      fixedSize: const Size(300, 100),
                      shadowColor: kShadowLanding,
                      elevation: 12,
                      textStyle: kLandingPageButtonsStyle,
                      shape: kRoundedRectangulareBorder50
                  ),
                )
            ),
          ]
          ),
        ),
      ),
    );
  }
}
