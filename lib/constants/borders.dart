import 'package:flutter/material.dart';

import 'colours.dart';

//border for chip widget
const kBorderRadiusChip = BorderRadius.all(
  Radius.circular(100),
);

const kBorderRadiusAll = BorderRadius.all(
  Radius.circular(10),
);

const kAllDirectionalCircularBorder = BorderRadiusDirectional.all(
Radius.circular(100)
);

const kRoundedRectangulareBorder =RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(20.0),
  ),
);


RoundedRectangleBorder kRoundedRectangulareBorder40 =RoundedRectangleBorder(
  borderRadius: kCircularBorderRadius40,
);
RoundedRectangleBorder kRoundedRectangulareBorder50 = RoundedRectangleBorder(
    borderRadius:kCircularBorderRadius50,
);


BorderRadius kCircularBorderRadius10 = BorderRadius.circular(10);
BorderRadius kCircularBorderRadius15 = BorderRadius.circular(15);
BorderRadius kCircularBorderRadius20 = BorderRadius.circular(20);
BorderRadius kCircularBorderRadius40 = BorderRadius.circular(40);
BorderRadius kCircularBorderRadius50 = BorderRadius.circular(50);
BorderRadius kCircularBorderRadius100 = BorderRadius.circular(100.0);


const BorderRadius kSymmetricBorderRadius2 = BorderRadius.only(
  topLeft: Radius.circular(20),
  bottomLeft: Radius.circular(20),
  bottomRight: Radius.circular(20),
  topRight: Radius.circular(20),
);

const BorderRadius kSymmetricBorderRadius3 = BorderRadius.only(
  topLeft: Radius.circular(30),
  bottomLeft: Radius.circular(30),
  bottomRight: Radius.circular(30),
  topRight: Radius.circular(30),
);

const BorderRadius kBorderRadiusTLeftTRight = BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30)
);

const BorderSide kBorderSideTertiaryColour = BorderSide(
  color: kTertiaryColour,
  width: 1.5,
);
const BorderSide kBorderSideTertiaryColour2 = BorderSide(
  color: kTertiaryColour,
  width: 1,
);

const OutlineInputBorder kOutlineBorder = OutlineInputBorder(
    borderRadius: kBorderRadiusAll,
    borderSide: BorderSide.none);