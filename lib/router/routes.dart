import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/email_verify/email_verify_screen.dart';
import 'package:project_seg/screens/home/home_screen.dart';
import 'package:project_seg/screens/home/profile/edit_password_screen.dart';
import 'package:project_seg/screens/home/profile/edit_preferences_screen.dart';
import 'package:project_seg/screens/home/profile/edit_profile_screen.dart';
import 'package:project_seg/screens/login/login_screen.dart';
import 'package:project_seg/screens/recover_password/recover_password_screen.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/screens/sign_up/register_description_screen.dart';
import 'package:project_seg/screens/sign_up/register_interests_screen.dart';
import 'package:project_seg/screens/sign_up/register_photo_screen.dart';
import 'package:project_seg/screens/sign_up/register_screen.dart';
import 'package:project_seg/screens/splash/splash_screen.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/user_state.dart';

class AppRouter {
  final UserState userState;

  AppRouter(this.userState);

  late final router = GoRouter(
    refreshListenable: userState,
    debugLogDiagnostics: false,
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: "splash",
        path: "/splash",
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
      GoRoute(
        name: "login",
        path: "/login",
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const LogInScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
      GoRoute(
        name: "verify_email",
        path: "/verify-email",
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const EmailVerifyScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
      GoRoute(
        name: "register",
        path: "/register",
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: RegisterScreen(),
        ),
        routes: [
          GoRoute(
            name: "register_basic_info",
            path: "basic-info",
            //builder: (context, state) => RegisterBasicInfoScreen(userData: (state.extra != null) ? state.extra as UserData : UserData()),
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: RegisterBasicInfoScreen(
                  userData: (state.extra != null)
                      ? state.extra as UserData
                      : UserData()),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: "register_photo",
            path: "photo",
            //builder: (context, state) => RegisterDescriptionScreen(userData: state.extra! as UserData),
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: RegisterPhotoScreen(userData: state.extra! as UserData),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: "register_description",
            path: "description",
            //builder: (context, state) => RegisterDescriptionScreen(userData: state.extra! as UserData),
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child:
                  RegisterDescriptionScreen(userData: state.extra! as UserData),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: "register_interests",
            path: "interests",
            //builder: (context, state) => RegisterInterestsScreen(userData: state.extra! as UserData),
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child:
                  RegisterInterestsScreen(userData: state.extra! as UserData),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        name: "recover_password",
        path: "/recover_password",
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: RecoverPasswordScreen(),
        ),
      ),
      GoRoute(
        name: "home",
        path: "/:page(profile|feed|chat)",
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: HomeScreen(page: state.params['page']!),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            name: "edit_profile",
            path: "edit-profile",
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: EditProfileScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: "edit_preferences",
            path: "edit-preferences",
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: EditPreferencesScreen(),
            ),
          ),
          GoRoute(
            name: "edit_password",
            path: "edit-password",
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: EditPasswordScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: Scaffold(
        body: Center(child: Text("Error: " + state.error.toString())),
      ),
    ),
    redirect: (state) {
      final initialized = userState.user != null;
      final loggedIn = userState.user?.user != null;
      final emailVerified = userState.user?.user?.emailVerified ?? false;
      final fetchedUser = userState.user?.userData != null;

      final splashLoc = state.namedLocation("splash");
      final loginLoc = state.namedLocation("login");
      final emailVerifyLoc = state.namedLocation("verify_email");
      final feedLoc = state.namedLocation("home", params: {'page': 'feed'});
      final recoverPasswordLoc = state.namedLocation("recover_password");
      final registerLoc = state.namedLocation("register");
      final registerBasicInfoLoc = state.namedLocation("register_basic_info");
      final registerPhotoLoc = state.namedLocation("register_photo");
      final registerDescriptionLoc =
          state.namedLocation("register_description");
      final registerInterestsLoc = state.namedLocation("register_interests");

      final goingToFeed = state.subloc == feedLoc;
      final goingToSplash = state.subloc == splashLoc;
      final goingToLogin = state.subloc == loginLoc;
      final goingToEmailVerify = state.subloc == emailVerifyLoc;
      final goingToRecoverPassword = state.subloc == recoverPasswordLoc;
      final goingToRegister = state.subloc == registerLoc;
      final goingToRegisterBasicInfo = state.subloc == registerBasicInfoLoc;
      final goingToRegisterPhoto = state.subloc == registerPhotoLoc;
      final goingToRegisterDescription = state.subloc == registerDescriptionLoc;
      final goingToRegisterInterests = state.subloc == registerInterestsLoc;

      /*
      print("State of the union: ");
      print("    initialized? ${initialized}");
      print("    logged in? ${loggedIn}");
      print("    email verified? ${emailVerified}");
      print("    fetched user data? ${fetchedUser}");
      print("----------");
      print("    goingToSplash? ${goingToSplash}");
      print("    goingToEmailVerify? ${goingToEmailVerify}");
      print("----------");
      print("    goingToLogin? ${goingToLogin}");
      print("    goingToRegister? ${goingToRegister}");
      print("    goingToRegisterBasicInfo? ${goingToRegisterBasicInfo}");
      print("    goingToRegisterPhoto? ${goingToRegisterPhoto}");
      print("    goingToRegisterDescription? ${goingToRegisterDescription}");
      print("    goingToRegisterInterests? ${goingToRegisterInterests}");
      print("#################################################");
      */

      if (!initialized && !goingToSplash) {
        return splashLoc;
      }

      if (initialized && loggedIn && !emailVerified && !goingToEmailVerify) {
        return emailVerifyLoc;
      }

      if (initialized &&
          !loggedIn &&
          !(goingToLogin || goingToRecoverPassword || goingToRegister)) {
        return loginLoc;
      }

      if (initialized &&
          loggedIn &&
          !fetchedUser &&
          emailVerified &&
          !(goingToRegisterBasicInfo ||
              goingToRegisterPhoto ||
              goingToRegisterDescription ||
              goingToRegisterInterests)) {
        return registerBasicInfoLoc;
      }

      if (initialized &&
          loggedIn &&
          fetchedUser &&
          (goingToSplash ||
              goingToEmailVerify ||
              goingToLogin ||
              goingToRegister ||
              goingToRegisterBasicInfo ||
              goingToRegisterPhoto ||
              goingToRegisterDescription ||
              goingToRegisterInterests) &&
          !goingToFeed) {
        return feedLoc;
      }

      return null;
    },
  );
}
