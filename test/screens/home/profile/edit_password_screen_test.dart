import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/delete_account_dialog.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';
import 'package:project_seg/screens/home/profile/edit_password_screen.dart';
import 'package:project_seg/screens/home/profile/edit_preferences_screen.dart';
import 'package:project_seg/screens/home/profile/edit_profile_screen.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/screens/home/profile/profile_screen.dart';
import 'package:project_seg/screens/log_in/login_screen.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;
  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group('Edit password screen:', () {
    testWidgets('Displays correct information', (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/profile/edit-password", null);

      final Finder sliverAppBarFinder = find.byType(SliverAppBar);
      expect(sliverAppBarFinder, findsOneWidget);

      final Finder sliverAppBarLeadingButtonFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(IconButton));
      expect(sliverAppBarLeadingButtonFinder, findsOneWidget);
      final IconButton sliverAppBarLeadingButton = tester.widget<IconButton>(sliverAppBarLeadingButtonFinder);
      expect(sliverAppBarLeadingButton.onPressed, isNotNull);

      final Finder sliverFillRemainingFinder = find.byType(SliverFillRemaining);
      expect(sliverFillRemainingFinder, findsOneWidget);

      final Finder textFormFieldFinder = find.descendant(of: sliverFillRemainingFinder, matching: find.byType(TextFormField));
      expect(textFormFieldFinder, findsNWidgets(3));

      final TextFormField currentPasswordField = tester.widget<TextFormField>(textFormFieldFinder.at(0));
      expect(currentPasswordField.controller, isNotNull);
      expect(currentPasswordField.validator, isNotNull);

      final TextFormField newPasswordField = tester.widget<TextFormField>(textFormFieldFinder.at(1));
      expect(newPasswordField.controller, isNotNull);
      expect(newPasswordField.validator, isNotNull);

      final TextFormField repeatPasswordField = tester.widget<TextFormField>(textFormFieldFinder.at(2));
      expect(repeatPasswordField.controller, isNotNull);
      expect(repeatPasswordField.validator, isNotNull);
    });

    testWidgets('Tapping back button returns normally', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/profile/edit-password", null);

      expect(find.byType(EditPasswordScreen), findsOneWidget);

      final Finder sliverAppBarFinder = find.byType(SliverAppBar);
      expect(sliverAppBarFinder, findsOneWidget);

      final Finder sliverAppBarLeadingButtonFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(IconButton));
      expect(sliverAppBarLeadingButtonFinder, findsOneWidget);
      final IconButton sliverAppBarLeadingButton = tester.widget<IconButton>(sliverAppBarLeadingButtonFinder);
      expect(sliverAppBarLeadingButton.onPressed, isNotNull);
      expect(() => sliverAppBarLeadingButton.onPressed!(), returnsNormally);
    });

    testWidgets('Edit password button returns normally with no inputs', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/profile/edit-password", null);

      expect(find.byType(EditPasswordScreen), findsOneWidget);

      final Finder saveButtonFinder = find.byType(PillButtonFilled);
      expect(saveButtonFinder, findsOneWidget);
      final PillButtonFilled saveButton = tester.widget<PillButtonFilled>(saveButtonFinder);

      expect(() => saveButton.onPressed(), returnsNormally);
    });

    testWidgets('Edit password button returns normally with acceptable inputs', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/profile/edit-password", null);

      expect(find.byType(EditPasswordScreen), findsOneWidget);

      final Finder sliverFillRemainingFinder = find.byType(SliverFillRemaining);
      expect(sliverFillRemainingFinder, findsOneWidget);

      final Finder textFormFieldFinder = find.descendant(of: sliverFillRemainingFinder, matching: find.byType(TextFormField));
      expect(textFormFieldFinder, findsNWidgets(3));

      await tester.enterText(textFormFieldFinder.at(0), "CorrectOldPassword");
      await tester.enterText(textFormFieldFinder.at(1), "CorrectNewPassword");
      await tester.enterText(textFormFieldFinder.at(2), "CorrectNewPassword");

      final Finder saveButtonFinder = find.byType(PillButtonFilled);
      expect(saveButtonFinder, findsOneWidget);
      final PillButtonFilled saveButton = tester.widget<PillButtonFilled>(saveButtonFinder);

      expect(() => saveButton.onPressed(), returnsNormally);
    });
  });
}
