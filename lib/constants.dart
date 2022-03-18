import 'package:flutter/material.dart';

const kBottomContainerHeight = 80.0;
const kActiveCardColor = Color(0xFF00CFFF);
const kInactiveCardColor = Colors.transparent;
const kActiveSliderColor = Color(0xFFEB1555);
const kInactiveSliderColor = Color(0xFF8D8E98);
const kBottomContainerColor = Color(0xFFEB1555);

//colours for chat
const kChatSenderColour = Color(0xFFADD8E6);
const kChatTextColour = Color(0xFF232B2B);
const kChatTimeColour = Color(0xFF7F7F7F);
const kChatReceiverColour = Color(0xFF87CEFA);
const kContactList = Color(0xFFADD8E6);
const kChatList = Color (0xFFB0E0E6);

//colours for next button
const kButtonBackground = Color(0xFF041731);


// colour scheme for the app
const kPrimaryColour = Color(0xFF0A1128);
const kSecondaryColour = Color(0xFF001F54);
const kTertiaryColour = Color(0xFF034078);
const kLightBlue = Color(0xFF1282A2);
const kWhiteColour = Color(0xFFFEFCFB);

const kLightTertiaryColour = Color.fromARGB(26, 3, 64, 120);

// Constants that identify each page's icon index in the navbar.
const int kProfileIconIndex = 0;
const int kFeedIconIndex = 1;
const int kChatIconIndex = 2;

// Constants for the font scaling of the profile containers.
const double kProfileNameFontSize = 30;
const double kProfileLocationFontSize = 18;

const kLabelTextStyle = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF8D8E98),
);

const kNumberTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.w900,
);

const kLargeButtonTextStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
);

//styling next button
const kNextButtonTextStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
);


const kTitleTextStyle = TextStyle(
  fontSize: 50.0,
  fontWeight: FontWeight.bold,
);

const kResultTextStyle = TextStyle(
  fontSize: 22.0,
  color: Color(0xFF24D876),
  fontWeight: FontWeight.bold,
);

const kBMITextStyle = TextStyle(
  fontSize: 100.0,
  fontWeight: FontWeight.bold,
);

const kBodyTextStyle = TextStyle(
  fontSize: 22.0,
);

//chat styling
const kContactListStyle = TextStyle(
    color: kWhiteColour,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 1,
);

const kContactListNamesStyle = TextStyle(
    color: kWhiteColour,
    fontSize: 16,
    fontWeight: FontWeight.w600,
);

const kInactiveSliderStyle = TextStyle(
    color: kInactiveSliderColor,
    fontSize: 15,
    fontWeight: FontWeight.bold,
);

const kUnreadTextStyle = TextStyle(
  color: Colors.grey,
  fontSize: 12,
  fontWeight: FontWeight.bold,
);

const kChatTextStyle = TextStyle(
  color: kChatTextColour,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

const kChatTimeStyle = TextStyle(
  color: kChatTimeColour,
  fontSize: 10,
  fontWeight: FontWeight.w600,
);

const kChatAppBarStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

//border for chip widget
const kBorderRadiusChip = BorderRadius.all(
  Radius.circular(100),
);


class GStyle {
    // notificatio 
    static badge(bool unread, {Color color = Colors.red, bool isdot = false, double height = 10.0, double width = 10.0}) {
        //final _num = count > 99 ? '···' : count;
        return Container(
            alignment: Alignment.center, height: !isdot ? height : height/2, width: !isdot ? width : width/2,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(100.0)),
            //child: !isdot ? Text('$_num', style: TextStyle(color: Colors.white, fontSize: 12.0)) : null
        );
    }
}
