import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/Sign_Up/register_screen.dart';
import 'package:project_seg/Sign_Up/register_basic_info_screen.dart';
import 'package:project_seg/Sign_Up/register_description_screen.dart';
import 'package:project_seg/Sign_Up/register_interests_screen.dart';
import 'package:project_seg/feed.dart';
import 'package:project_seg/home_screen.dart';
import 'package:project_seg/log_in.dart';
import 'package:project_seg/recoverPassword.dart';
import 'package:project_seg/services/UserState.dart';
import 'package:project_seg/splash_screen.dart';

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
          child: const LogIn(),
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
              child: RegisterDescriptionScreen(),
            ),
          ),
          GoRoute(
            name: "register_interests",
            path: "interests",
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: RegisterInterestsScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        name: "recover_password",
        path: "/recover_password",
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: recoverPassword(),
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
      final fetchedUser = userState.user?.userData != null;

      final splashLoc = state.namedLocation("splash");
      final loginLoc = state.namedLocation("login");
      final feedLoc = state.namedLocation("home", params: {'page': 'feed'});
      final recoverPasswordLoc = state.namedLocation("recover_password");
      final registerLoc = state.namedLocation("register");
      final registerBasicInfoLoc = state.namedLocation("register_basic_info");
      final registerDescriptionLoc = state.namedLocation("register_description");
      final registerInterestsLoc = state.namedLocation("register_interests");

      final goingToSplash = state.subloc == splashLoc;
      final goingToLogin = state.subloc == loginLoc;
      final goingToRecoverPassword = state.subloc == recoverPasswordLoc;
      final goingToRegister = state.subloc == registerLoc;
      final goingToRegisterBasicInfo = state.subloc == registerBasicInfoLoc;
      final goingToRegisterDescriptionLoc = state.subloc == registerDescriptionLoc;
      final goingToRegisterInterestsLoc = state.subloc == registerInterestsLoc;

      if (!initialized && !goingToSplash) {
        return splashLoc;
      }

      if (initialized && !loggedIn && !(goingToLogin || goingToRecoverPassword || goingToRegister)) {
        return loginLoc;
      }

      if (initialized &&
          loggedIn &&
          !fetchedUser &&
          !(goingToRegisterBasicInfo || goingToRegisterDescriptionLoc || goingToRegisterInterestsLoc)) {
        return registerBasicInfoLoc;
      }

      if ((initialized && goingToSplash) ||
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
