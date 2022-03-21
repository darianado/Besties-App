import 'package:flutter/material.dart';

//border for chip widget
const kBorderRadiusChip = BorderRadius.all(
  Radius.circular(100),
);

const kAllDirectionalCircularBorder = BorderRadiusDirectional.all(
Radius.circular(100)
);

const kRoundedRectangulareBorder =RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(20.0),
  ),
);

BorderRadius kCircularBorderRadius = BorderRadius.circular(100.0);

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
