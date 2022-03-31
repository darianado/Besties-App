import 'package:firebase_auth/firebase_auth.dart';

/// Definition of various Firebase Authentication related result statuses.
enum AuthResultStatus {
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
  weakPassword,
  emailNotVerified
}

/// Class containing utility methods to create human-readable error messages from different [FirebaseAuthException].
class AuthExceptionHandler {
  /// Converts an [FirebaseAuthException] to an instance of [AuthResultStatus].
  static handleException(FirebaseAuthException e) {
    AuthResultStatus status;
    switch (e.code) {
      case "invalid-email":
        status = AuthResultStatus.invalidEmail;
        break;
      case "wrong-password":
        status = AuthResultStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthResultStatus.userNotFound;
        break;
      case "user-disabled":
        status = AuthResultStatus.userDisabled;
        break;
      case "too-many-requests":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "operation-not-allowed":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "email-already-in-use":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case "weak-password":
        status = AuthResultStatus.weakPassword;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  /// Converts an [AuthResultStatus] to a [String] describing the status in human terms.
  static generateExceptionMessage(AuthResultStatus status) {
    String errorMessage;
    switch (status) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Please enter a valid email address.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "The password you typed is incorrect. Please try again!";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist. Please create an account!";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage = "The email has already been registered. Please login or reset your password.";
        break;
      case AuthResultStatus.weakPassword:
        errorMessage = "The password must be at least 6 characters long.";
        break;
      case AuthResultStatus.emailNotVerified:
        errorMessage = "A verification email has been sent to this account, please verify your email in order to login";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }

  /// Converts an [FirebaseAuthException] to a [String].
  static generateExceptionMessageFromException(FirebaseAuthException e) {
    return generateExceptionMessage(handleException(e));
  }
}
