import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/home/feed/profile_container.dart';
import 'package:project_seg/router/routes.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/sliding_profile_details.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/screens/home/profile/profile_screen.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/screens/sign_up/register_description_screen.dart';

/// Holds static methods to pump widgets for testing purposes.
abstract class WidgetPumper {
  /// Pumps a [ProfileContainer] for testing purposes
  static pumpProfileContainer(
      WidgetTester tester, ValueKey key, OtherUser profile) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          return ChangeNotifierProvider<UserState>.value(
            value: UserState.instance,
            child: MaterialApp(
              home: Scaffold(
                body: ProfileContainer(
                    key: key, profile: profile, onLikeComplete: () => {}),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Pumps a [SlidingProfileDetails] for testing purposes
  static pumpSlidingProfileDetails(
      WidgetTester tester, ValueKey key, OtherUser profile) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          return ChangeNotifierProvider<UserState>.value(
            value: UserState.instance,
            child: ChangeNotifierProvider<ContextState>.value(
              value: ContextState.instance,
              child: MaterialApp(
                home: Scaffold(
                  body: SlidingProfileDetails(
                      key: key, profile: profile.userData),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Pumps a [ProfileInformation] for testing purposes
  static pumpProfileScreen(WidgetTester tester, ValueKey key, UserData profile) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          return ChangeNotifierProvider<UserState>.value(
            value: UserState.instance,
            child: ChangeNotifierProvider<ContextState>.value(
              value: ContextState.instance,
              child: MaterialApp(
                home: Scaffold(
                  body: ProfileInformation(editable: false, key: key, userData: profile),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

     /// Pumps a [RegisterBasicInfoScreen] for testing purposes
  static pumpRegisterBasicInfoScreen(
      WidgetTester tester, ValueKey key, UserData userData) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          return ChangeNotifierProvider<UserState>.value(
            value: UserState.instance,
            child: ChangeNotifierProvider<ContextState>.value(
              value: ContextState.instance,
              child: MaterialApp(
                home: Scaffold(
                  body: RegisterBasicInfoScreen(key: key, userData: userData),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

    /// Pumps a [RegisterBasicInfoScreen] for testing purposes
  static pumpRegisterDescriptionScreen(
      WidgetTester tester, ValueKey key, UserData userData) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          return ChangeNotifierProvider<UserState>.value(
            value: UserState.instance,
            child: ChangeNotifierProvider<ContextState>.value(
              value: ContextState.instance,
              child: MaterialApp(
                home: Scaffold(
                  body: RegisterDescriptionScreen(key: key, userData: userData),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  

}

