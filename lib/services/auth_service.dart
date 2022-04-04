import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart' as mock_auth;

/// The entry point for authentication services.
///
/// This class uses [FirebaseAuth] to provide authentication services
/// to the whole application.Through [firebaseAuth] you can access
/// the logged in user's data as well as listen for any user changes.
class AuthService {
  final auth.FirebaseAuth firebaseAuth;

  Timer? timer;

  AuthService({required this.firebaseAuth});

  /// Gets changes to any user updates.
  Stream<auth.User?> get user {
    return firebaseAuth.userChanges();
  }

  /// Returns the currently logged in user, if it exists.
  auth.User? get currentUser {
    return firebaseAuth.currentUser;
  }

  /// Signs the user in with the given [email] and [password].
  Future<void> signIn(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  /// Signs the user up with the given [email] and [password].
  Future<void> signUp(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((_) async {
      await sendVerificationEmail();
    });
  }

  /// Signs the [currentUser] out.
  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }

  /// Deletes the [currentUser] upon [password] validation.
  Future<void> deleteAccount(String password) async {
    final verified = await validatePassword(password);
    if (verified) {
      return await firebaseAuth.currentUser?.delete();
    }
  }

  /// Sends a verification email to the [currentUser].
  Future<void> sendVerificationEmail() async {
    // For testing purposes - mock package does not support emails.
    if (firebaseAuth is mock_auth.MockFirebaseAuth) return;

    await currentUser?.sendEmailVerification(null);
  }

  /// Refreshes the [currentUser], if signed in.
  ///
  /// Catches an [auth.FirebaseAuthException] if the user is not signed in.
  Future<void> reloadUser() async {
    try {
      await firebaseAuth.currentUser?.reload();
    } catch (e) {
      // calling reload on a null user.
      return;
    }
  }

  /// Periodically checks if the [currentUser]'s email has been verified.
  ///
  /// This method starts a periodic [timer] that will automatically
  /// stop after the [currentUser] has been verified.
  void startCheckingForVerifiedEmail() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await reloadUser();
        if (currentUser?.emailVerified == true) {
          timer.cancel();
        }
      },
    );
  }

  /// Cancels the [timer] if it has been set.
  void stopCheckingForVerifiedEmail() {
    timer?.cancel();
  }

  /// Sends a password reset email to the [currentUser].
  Future<void> resetPassword(String email) async {
    // For testing purposes - mock package does not support emails.
    if (firebaseAuth is mock_auth.MockFirebaseAuth) return;

    return await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  /// Changes the [currentUser]'s [currentPassword] to the given [newPassword].
  Future<void> changePassword(String currentPassword, String newPassword) async {
    auth.User? user = currentUser;
    if (user == null) {
      return;
    }

    await validatePassword(currentPassword);
    await user.updatePassword(newPassword);
  }

  /// Authenticates the [currentUser] using fresh credentials.
  Future<bool> validatePassword(String password) async {
    auth.User? user = currentUser;
    if (user == null) {
      return false;
    }

    final credentials = auth.EmailAuthProvider.credential(email: user.email!, password: password);
    await user.reauthenticateWithCredential(credentials);
    return true;
  }
}
