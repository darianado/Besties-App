import 'package:flutter/material.dart';
import 'colours.dart';

// Constants that identify each page's icon index in the navbar.
const int kProfileIconIndex = 0;
const int kFeedIconIndex = 1;
const int kChatIconIndex = 2;

// Constants for the font scaling of the profile containers.
const double kProfileNameFontSize = 30;
const double kProfileLocationFontSize = 18;

class GStyle {
  // notificatio
  static badge(bool unread, {Color color = Colors.red, bool isdot = false, double height = 10.0, double width = 10.0}) {
    //final _num = count > 99 ? '···' : count;
    return Container(
      alignment: Alignment.center, height: !isdot ? height : height / 2, width: !isdot ? width : width / 2,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(100.0)),
      //child: !isdot ? Text('$_num', style: TextStyle(color: Colors.white, fontSize: 12.0)) : null
    );
  }
}
