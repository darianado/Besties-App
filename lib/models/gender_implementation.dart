import 'package:flutter/material.dart';
import '../constants.dart';
import '../screens/components/icon_content.dart';
import '../screens/components/widgets.dart';
import '../screens/components/reusable_card.dart';

enum Gender { male, female, other }

String genderLabel(Gender gender) {
  switch (gender) {
    case Gender.male:
      return "MALE";
    case Gender.female:
      return "FEMALE";
    case Gender.other:
      return "OTHER";
  }
}
