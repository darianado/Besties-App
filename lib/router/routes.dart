import 'package:flutter/material.dart';
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
import 'package:project_seg/screens/sign_up/register_screen.dart';
import 'package:project_seg/screens/splash/splash_screen.dart';
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
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
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: RegisterBasicInfoScreen(),
            ),
          ),
          GoRoute(
            name: "register_description",
            path: "description",
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: RegisterDescriptionScreen(userData: state.extra! as UserData),
            ),
          ),
          GoRoute(
            name: "register_interests",
            path: "interests",
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: RegisterInterestsScreen(userData: state.extra! as UserData),
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
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            name: "edit_profile",
            path: "edit-profile",
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: EditProfileScreen(),
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
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: EditPasswordScreen(),
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
      final registerDescriptionLoc = state.namedLocation("register_description");
      final registerInterestsLoc = state.namedLocation("register_interests");

      final goingToSplash = state.subloc == splashLoc;
      final goingToLogin = state.subloc == loginLoc;
      final goingToEmailVerify = state.subloc == emailVerifyLoc;
      final goingToRecoverPassword = state.subloc == recoverPasswordLoc;
      final goingToRegister = state.subloc == registerLoc;
      final goingToRegisterBasicInfo = state.subloc == registerBasicInfoLoc;
      final goingToRegisterDescriptionLoc = state.subloc == registerDescriptionLoc;
      final goingToRegisterInterestsLoc = state.subloc == registerInterestsLoc;

      if (!initialized && !goingToSplash) {
        return splashLoc;
      }

      if (initialized && loggedIn && !emailVerified && !goingToEmailVerify) {
        return emailVerifyLoc;
      }

      if (initialized && !loggedIn && !(goingToLogin || goingToRecoverPassword || goingToRegister)) {
        return loginLoc;
      }
      /*
      if (initialized &&
          loggedIn &&
          (emailVerified && goingToEmailVerify) &&
          !fetchedUser &&
          !(goingToRegisterBasicInfo || goingToRegisterDescriptionLoc || goingToRegisterInterestsLoc)) {
        return registerBasicInfoLoc;
      }
      */
      if (initialized &&
          loggedIn &&
          emailVerified &&
          !fetchedUser &&
          !(goingToRegisterBasicInfo || goingToRegisterDescriptionLoc || goingToRegisterInterestsLoc)) {
        return registerBasicInfoLoc;
      }

      if ((initialized && goingToSplash) ||
          (emailVerified && goingToEmailVerify) ||
          (loggedIn &&
              fetchedUser &&
              (goingToLogin ||
                  goingToRegister ||
                  goingToRegisterBasicInfo ||
                  goingToRegisterDescriptionLoc ||
                  goingToRegisterInterestsLoc))) {
        return feedLoc;
      }

      return null;
    },
  );
}
