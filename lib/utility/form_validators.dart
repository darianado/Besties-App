import 'package:email_validator/email_validator.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';

String? validateNotEmpty(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return '$fieldName must be filled in.';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || !EmailValidator.validate(value.trim())) {
    return "Please check your email is in the right format";
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  return null;
}

String? validateRepeatedPassword(String? value, String? validateAgainst) {
  final validateValue = validatePassword(value);
  if (validateValue != null) {
    return validateValue;
  }

  if (value != validateAgainst) {
    return "Please type the same password";
  }

  return null;
}

String? validateExistsAndDifferentFrom(String? value, String validateAgainst) {
  final validateValue = validatePassword(value);
  if (validateValue != null) {
    return validateValue;
  }

  if (value == validateAgainst) {
    return "Cannot be the same as before";
  }

  return null;
}

String? validateRelationshipStatus(String? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

String? validateGender(String? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

String? validateDOB(DateTime? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

String? validateProfileImageUrl(String? value) {
  if (value == null) return "You must set a profile picture.";
  return null;
}

String? validateBio(String? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

String? validateUniversity(String? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

String? validateInterests(CategorizedInterests? value) {
  if (value == null) return "You must fill in this field";

  final _flattenedInterests = value.flattenedInterests;
  if (_flattenedInterests.length < 1 || _flattenedInterests.length > 10) {
    return "Select between 1 and 10 interests";
  }

  return null;
}
