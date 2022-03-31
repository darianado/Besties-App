import 'package:email_validator/email_validator.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';

/// Validates that the [value] is not null.
///
/// If the [value] is null, an error message is returned with the [fieldName] as prefix.
String? validateNotEmpty(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return '$fieldName must be filled in.';
  }
  return null;
}

/// Validates that the [value] is not null and that it is a valid email.
///
/// If the [value] is null, or the value is not a valid email
/// according to the [EmailValidator], an error message is returned.
String? validateEmail(String? value) {
  if (value == null || !EmailValidator.validate(value.trim())) {
    return "Please check your email is in the right format";
  }
  return null;
}

/// Validates that the [value] is not null or is the empty string.
///
/// If the [value] is null, an error message is returned.
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  }
  return null;
}

/// Validates that the given [value] is a valid password
/// according to [validatePassword], and that it is equal to [validateAgainst].
///
/// If any of these checks fails, an error message is returned.
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

/// Validates that the given [value] is a valid password
/// according to [validatePassword], and that it is not equal to [validateAgainst].
///
/// If any of these checks fails, an error message is returned.
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

/// Validates that the [value] is not null.
///
/// If the [value] is null, an error message is returned.
String? validateRelationshipStatus(String? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

/// Validates that the [value] is not null.
///
/// If the [value] is null, an error message is returned.
String? validateGender(String? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

/// Validates that the [value] is not null.
///
/// If the [value] is null, an error message is returned.
String? validateDOB(DateTime? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

/// Validates that the [value] is not null.
///
/// If the [value] is null, an error message is returned.
String? validateProfileImageUrl(String? value) {
  if (value == null) return "You must set a profile picture.";
  return null;
}

/// Validates that the [value] is not null.
///
/// If the [value] is null, an error message is returned.
String? validateBio(String? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

/// Validates that the [value] is not null.
///
/// If the [value] is null, an error message is returned.
String? validateUniversity(String? value) {
  if (value == null) return "You must fill in this field.";
  return null;
}

/// Validates that the [value] is not null, and that it contains between [min] and [max] interests.
///
/// If either of these checks fails, an error message is returned.
/// If [min] is null, a value of 1 will be used. If [max] is null, a value of 10 will be used.
String? validateInterests(CategorizedInterests? value, int? min, int? max) {
  if (value == null) return "You must fill in this field";

  min = (min != null) ? min : 1;
  max = (max != null) ? max : 10;

  final _flattenedInterests = value.flattenedInterests;
  if (_flattenedInterests.length < min || _flattenedInterests.length > max) {
    return "Select between $min and $max interests";
  }

  return null;
}
