import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_seg/dalu_auth/my_user.dart';

//ios testing still required

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

class AuthExceptionHandler {
  static handleException(FirebaseAuthException e) {
    //print(e.code);
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

  static generateExceptionMessage(AuthResultStatus status) {
    String errorMessage;
    switch (status) {
      case AuthResultStatus.invalidEmail:
        errorMessage = "Please enter a valid email address.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is incorrect.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
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
        errorMessage = "The password must be 6 characters long or more.";
        break;
      case AuthResultStatus.emailNotVerified:
        errorMessage = "A verification email has been sent to this account, please verify your email in order to login";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }

  static generateExceptionMessageFromException(FirebaseAuthException e) {
    return generateExceptionMessage(handleException(e));
  }
}

/*
class FirebaseAuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var _status;
  var _user;

  //create user obj based on firebase user
  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<AuthResultStatus> createAccount({email, pass}) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      if (authResult.user != null) {
        authResult.user!.sendEmailVerification(null);
        logOut(); //call logout so that user is not redirected to feed until they  verify
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> login({email, pass}) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(email: email, password: pass);

      if (authResult.user!.emailVerified) {
        //creates user object only if  their email is verified
        _user = _userFromFirebaseUser(authResult.user);
      } else {
        _user = _userFromFirebaseUser(null);
      }

      if (_user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.emailNotVerified;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future changePassword({currentPass, newPass}) async {
    AuthResultStatus _status = await validatePassword(currentPass);
    if (_status == AuthResultStatus.successful) {
      try {
        await _auth.currentUser!.updatePassword(newPass);
      } on FirebaseAuthException catch (e) {
        _status = AuthExceptionHandler.handleException(e);
      }
      return _status;
    } else {
      _status = AuthResultStatus.wrongPassword; //password doesnt match
      return _status;
    }
  }

  Future validatePassword(String password) async {
    var _currentUser = _auth.currentUser;
    var email = nullSafeUserEmail(_currentUser!.email);
    var userCredentials = EmailAuthProvider.credential(email: email, password: password);
    try {
      var reauthenticatedCredentials = await _currentUser.reauthenticateWithCredential(userCredentials);

      if (_currentUser.email == reauthenticatedCredentials.user!.email) {
        _status = AuthResultStatus.successful;
      }
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  String nullSafeUserEmail(String? email) {
    //get user email from firebase ensuring its non null
    if (email == null) {
      return '';
    } else {
      return email;
    }
  }

  getUser() {
    return _user;
  }

  Future logOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
  }

  Future resetPassword(String email) async {
    //TO DO check if user with that email is verified before sending password reset
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
      return _status;
    }
  }
}
*/