import 'package:flutter/material.dart';
import 'constants.dart';
import 'iconContent.dart';
import 'widgets.dart';
import 'reusableCard.dart';

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


