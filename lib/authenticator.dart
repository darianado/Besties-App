import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_seg/models/my_user.dart';


//ios testing still required

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
  weakPassword,
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

  static generateExceptionMessage(AuthResultStatus exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
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
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      case AuthResultStatus.weakPassword:
        errorMessage = "The password must be 6 characters long or more.";
        break;        
      default:
        errorMessage = "An undefined Error happened.";
    }

    return errorMessage;
  }
}

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
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (authResult.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> login({email, pass}) async {
    try {
      final authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      _user = _userFromFirebaseUser(authResult.user);
      if (_user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } on FirebaseAuthException catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

   Future changePassword({currentPass,newPass}) async {

    AuthResultStatus _status = await validatePassword(currentPass);
    if (_status==AuthResultStatus.successful){
        try {
         await  _auth.currentUser!.updatePassword(newPass);
        } on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
     }
     return _status;
    }

   else {
     _status = AuthResultStatus.wrongPassword; //password doesnt match
     return _status;
   }

  }
  

   Future validatePassword(String password) async {
      var _user =  _auth.currentUser;
      var email = getUserEmail(_user!.email);
      var userCredentials = EmailAuthProvider.credential(email: email, password: password);
    try {
      var reauthenticatedCredentials = await _user.reauthenticateWithCredential(userCredentials);

      if (_user.email== reauthenticatedCredentials.user!.email) { 
        _status = AuthResultStatus.successful;
      }
    }
     on FirebaseAuthException catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status ; 
  }



String getUserEmail(String? email){ //get user email from firebase ensuring its non null
  if (email ==null){
    return'';
  }

  else {
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
  // logout() {
  //   _auth.signOut();
  // }
}
