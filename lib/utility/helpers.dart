import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Returns the difference of two numbers.
///
/// If either of the two numbers are null, it returns 0.
double difference(double? n1, double? n2) {
  return (n1 != null && n2 != null) ? n2 - n1 : 0;
}

/// Returns the icon associated with a given gender.
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

/// Splits a list of [String]s into a list of lists of [String], where each
/// inner list is at most [size] in length.
List<List<String>> split(List<String> lst, int size) {
  List<List<String>> results = [];

  for (var i = 0; i < lst.length; i += size) {
    final end = (i + size < lst.length) ? i + size : lst.length;
    results.add(lst.sublist(i, end));
  }

  return results;
}
