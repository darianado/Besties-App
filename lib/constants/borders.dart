import 'package:flutter/material.dart';
import 'colours.dart';


const kBorderRadiusAll = BorderRadius.all(kRadius10);

//border for chip widget
const kBorderRadiusChip = BorderRadius.all(kRadius100);

const kRadius10 = Radius.circular(10.0);
const kRadius20 = Radius.circular(20.0);
const kRadius30 = Radius.circular(30.0);
const kRadius100 = Radius.circular(100.0);

const kAllDirectionalCircularBorder = BorderRadiusDirectional.all(kRadius100);


const kRoundedRectangulareBorder =RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    top: kRadius20,
  ),
);


RoundedRectangleBorder kRoundedRectangulareBorder40 =RoundedRectangleBorder(
  borderRadius: kCircularBorderRadius40,
);

RoundedRectangleBorder kRoundedRectangulareBorder50 = RoundedRectangleBorder(
    borderRadius:kCircularBorderRadius50,
);


BorderRadius kCircularBorderRadius10 = BorderRadius.circular(10.0);
BorderRadius kCircularBorderRadius15 = BorderRadius.circular(15.0);
BorderRadius kCircularBorderRadius20 = BorderRadius.circular(20.0);
BorderRadius kCircularBorderRadius40 = BorderRadius.circular(40.0);
BorderRadius kCircularBorderRadius50 = BorderRadius.circular(50.0);
BorderRadius kCircularBorderRadius100 = BorderRadius.circular(100.0);


const BorderRadius kSymmetricBorderRadius2 = BorderRadius.all(kRadius20);

const BorderRadius kSymmetricBorderRadius3 = BorderRadius.all(kRadius30);

const BorderRadius kBorderRadiusTLeftTRight = BorderRadius.only(
    topLeft: kRadius30,
    topRight: kRadius30,
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