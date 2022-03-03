import 'package:flutter/material.dart';
import 'constants.dart';
import 'icon_content.dart';
import 'widgets.dart';
import 'reusable_card.dart';

enum Gender {
  male,
  female,
  other
}

String genderLabel(Gender gender) {
  switch(gender) {
    case Gender.male: return "MALE";
    case Gender.female: return "FEMALE";
    case Gender.other: return "OTHER";
  }
}


