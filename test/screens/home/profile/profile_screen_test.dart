import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/screens/home/profile/profile_screen.dart';
import '../../../test_resources/helpers.dart';
import '../../../test_resources/firebase_mocks.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';

import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  /*
  group('ProfileScreen widget tests', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/profile", null);

      expect(find.byType(ProfileScreen), findsOneWidget);

      /// Test change button

      final Finder changePasswordButtonFinder = find.widgetWithText(PillButtonFilled, "Change password");
      expect(changePasswordButtonFinder, findsOneWidget);

      final PillButtonFilled changePasswordButton = tester.widget<PillButtonFilled>(changePasswordButtonFinder);
      expect(changePasswordButton.onPressed, isNotNull);
      expect(changePasswordButton.textStyle?.color, whiteColour);

      expect(changePasswordButton.icon, isA<Icon>());
      final Icon changePasswordButtonIcon = (changePasswordButton.icon as Icon);
      expect(changePasswordButtonIcon, isNotNull);
      expect(changePasswordButtonIcon.color, whiteColour);
      expect(changePasswordButtonIcon.icon, FontAwesomeIcons.lock);

      /// Test sign out button

      final Finder SignOutButtonFinder = find.widgetWithText(PillButtonOutlined, "Sign out");
      expect(SignOutButtonFinder, findsOneWidget);

      final PillButtonOutlined SignOutButton = tester.widget<PillButtonOutlined>(SignOutButtonFinder);
      expect(SignOutButton.onPressed, isNotNull);
      expect(SignOutButton.textStyle?.color, Colors.red);

      expect(SignOutButton.icon, isA<Icon>());
      final Icon SignOutButtonIcon = (SignOutButton.icon as Icon);
      expect(SignOutButtonIcon, isNotNull);
      expect(SignOutButtonIcon.color, Colors.red);
      expect(SignOutButtonIcon.icon, FontAwesomeIcons.signOutAlt);
    });

    testWidgets("Clicking sign out button signs out", (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/profile", null);

      expect(find.byType(ProfileScreen), findsOneWidget);

      expect(_widgetPumper.firebaseEnv.userState.user?.user?.uid, isNotNull);

      final Finder SignOutButtonFinder = find.byType(PillButtonOutlined);
      expect(SignOutButtonFinder, findsOneWidget);

      final PillButtonOutlined SignOutButton = tester.widget<PillButtonOutlined>(SignOutButtonFinder);
      expect(SignOutButton.onPressed, isNotNull);
      SignOutButton.onPressed();

      await tester.pump();

      expect(_widgetPumper.firebaseEnv.userState.user?.user?.uid, isNull);
    });

    testWidgets("Clicking change password redirects to the change password page", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/profile", null);

      await tester.idle();
      await tester.pump(Duration(seconds: 2));

      //print(find.byElementPredicate((element) => true).allCandidates.map((e) => "$e \n").toList());

      final Finder changePasswordButtonFinder = find.widgetWithText(PillButtonFilled, "Change password");
      expect(changePasswordButtonFinder, findsOneWidget);
      // final changePasswordButton = tester.widget<PillButtonFilled>(changePasswordButtonFinder);
      // expect(changePasswordButton.onPressed, isNotNull);

      //changePasswordButton.onPressed();
      //
      // await tester.pump();
    });

    //expect(find.textContaining("John"), findsOneWidget);
    //expect(find.textContaining("Doe"), findsOneWidget);

    //expect(find.textContaining("King's College London"), findsOneWidget);
    // expect(find.text(firstProfile.userData.age!.toString()), findsOneWidget);
    //
    // expect(find.text(firstProfile.userData.relationshipStatus!), findsOneWidget);
    // expect(find.text(firstProfile.userData.bio!), findsOneWidget);
    //
    // expect(find.byType(DisplayInterests), findsOneWidget);
    // expect(find.byType(GenderButton), findsOneWidget);
  });
  */
}
