import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double difference(double? n1, double? n2) {
  return (n1 != null && n2 != null) ? n2 - n1 : 0;
}

IconData getIconForGender(String? gender) {
  switch (gender?.toLowerCase()) {
    case "male":
      return FontAwesomeIcons.mars;
    case "female":
      return FontAwesomeIcons.venus;
    default:
      return FontAwesomeIcons.venusMars;
  }
}
