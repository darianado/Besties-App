import 'package:flutter/material.dart';
import 'colours.dart';


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
