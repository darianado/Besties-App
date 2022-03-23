import 'package:email_validator/email_validator.dart';

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
