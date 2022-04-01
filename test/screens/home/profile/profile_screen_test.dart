import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/home/profile/edit_password_screen.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/screens/home/profile/profile_screen.dart';
import 'package:project_seg/screens/log_in/login_screen.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group('ProfileScreen widget tests', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/profile", null);

      expect(find.byType(ProfileScreen), findsOneWidget);

      final Finder profileInformationFinder = find.byType(ProfileInformation);
      expect(profileInformationFinder, findsOneWidget);
      final ProfileInformation profileInformation = tester.widget<ProfileInformation>(profileInformationFinder);

      expect(_widgetPumper.firebaseEnv.userState.user?.userData, profileInformation.userData);

      expect(find.textContaining("John"), findsOneWidget);
      expect(find.textContaining("Doe"), findsOneWidget);

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

      final Finder signOutButtonFinder = find.byType(PillButtonOutlined);
      expect(signOutButtonFinder, findsOneWidget);

      final PillButtonOutlined signOutButton = tester.widget<PillButtonOutlined>(signOutButtonFinder);
      expect(signOutButton.onPressed, isNotNull);

      expect(() => signOutButton.onPressed(), returnsNormally);

      await tester.pumpAndSettle();

      expect(find.byType(LogInScreen), findsOneWidget);

      expect(_widgetPumper.firebaseEnv.userState.user?.user?.uid, isNull);
    });

    testWidgets("Clicking change password redirects to change password screen", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/profile", null);

      expect(find.byType(ProfileScreen), findsOneWidget);

      final Finder changePasswordButtonFinder = find.widgetWithText(PillButtonFilled, "Change password");
      expect(changePasswordButtonFinder, findsOneWidget);

      final changePasswordButton = tester.widget<PillButtonFilled>(changePasswordButtonFinder);
      expect(changePasswordButton.onPressed, isNotNull);

      expect(() => changePasswordButton.onPressed(), returnsNormally);

      await tester.pumpAndSettle();

      expect(find.byType(EditPasswordScreen), findsOneWidget);
    });

    testWidgets("Clicking edit profile returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/profile", null);

      expect(find.byType(ProfileScreen), findsOneWidget);

      final Finder editProfileButtonFinder = find.byType(RoundActionButton);
      expect(editProfileButtonFinder, findsOneWidget);
      final RoundActionButton editProfileButton = tester.widget<RoundActionButton>(editProfileButtonFinder);
      expect(editProfileButton.onPressed, isNotNull);
      expect(() => editProfileButton.onPressed!(), returnsNormally);
    });
  });
}
