import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/email_verify/email_verify_screen.dart';
import 'package:project_seg/screens/home/chat/chat_thread_screen.dart';
import 'package:project_seg/screens/home/chat/match_profile_screen.dart';
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
        name: splashScreenName,
        path: splashScreenPath,
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
        name: loginScreenName,
        path: loginScreenPath,
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
        name: verifyEmailScreenName,
        path: verifyEmailScreenPath,
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
        name: registerScreenName,
        path: registerScreenPath,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const RegisterScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            name: registerBasicInfoScreenName,
            path: registerBasicInfoScreenPath,
            //builder: (context, state) => RegisterBasicInfoScreen(userData: (state.extra != null) ? state.extra as UserData : UserData()),
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: RegisterBasicInfoScreen(userData: (state.extra != null) ? state.extra as UserData : UserData()),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: registerPhotoScreenName,
            path: registerPhotoScreenPath,
            //builder: (context, state) => RegisterDescriptionScreen(userData: state.extra! as UserData),
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: RegisterPhotoScreen(userData: state.extra! as UserData),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: registerDescriptionScreenName,
            path: registerDescriptionScreenPath,
            //builder: (context, state) => RegisterDescriptionScreen(userData: state.extra! as UserData),
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: RegisterDescriptionScreen(userData: state.extra! as UserData),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: registerInterestsScreenName,
            path: registerInterestsScreenPath,
            //builder: (context, state) => RegisterInterestsScreen(userData: state.extra! as UserData),
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: RegisterInterestsScreen(userData: state.extra! as UserData),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        name: recoverPasswordScreenName,
        path: recoverPasswordScreenPath,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const RecoverPasswordScreen(),
        ),
      ),
      GoRoute(
        name: homeScreenName,
        path: homeScreenPath,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: HomeScreen(page: state.params[pageParameterKey]!),
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        routes: [
          GoRoute(
            name: editProfileScreenName,
            path: editProfileScreenPath,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const EditProfileScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: editPreferencesScreenName,
            path: editPreferencesScreenPath,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const EditPreferencesScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: editPasswordScreenName,
            path: editPasswordScreenPath,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: const EditPasswordScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: matchProfileScreenName,
            path: matchProfileScreenPath,
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              child: MatchProfileScreen(userMatch: state.extra! as UserMatch),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
          GoRoute(
            name: matchChatScreenName,
            path: matchChatScreenPath,
            pageBuilder: (context, state) => MaterialPage<void>(
              key: state.pageKey,
              child: ChatThreadScreen(userMatch: state.extra! as UserMatch),
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

      final splashLoc = state.namedLocation(splashScreenName);
      final loginLoc = state.namedLocation(loginScreenName);
      final emailVerifyLoc = state.namedLocation(verifyEmailScreenName);
      final feedLoc = state.namedLocation(homeScreenName, params: {pageParameterKey: feedScreenName});
      final recoverPasswordLoc = state.namedLocation(recoverPasswordScreenName);
      final registerLoc = state.namedLocation(registerScreenName);
      final registerBasicInfoLoc = state.namedLocation(registerBasicInfoScreenName);
      final registerPhotoLoc = state.namedLocation(registerPhotoScreenName);
      final registerDescriptionLoc = state.namedLocation(registerDescriptionScreenName);
      final registerInterestsLoc = state.namedLocation(registerInterestsScreenName);

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

      if (initialized && !loggedIn && !(goingToLogin || goingToRecoverPassword || goingToRegister)) {
        return loginLoc;
      }

      if (initialized &&
          loggedIn &&
          !fetchedUser &&
          emailVerified &&
          !(goingToRegisterBasicInfo || goingToRegisterPhoto || goingToRegisterDescription || goingToRegisterInterests)) {
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
