import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';

import '../../test_resources/helpers.dart';
import '../../test_resources/testing_data.dart';
import '../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;
  const String userEmail = "markdoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Register basic info screen:", () {
    testWidgets('basic sign up page has all the field widgets', (WidgetTester tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-basic-info", null);

      expect(find.byType(RegisterBasicInfoScreen), findsOneWidget);

      final Finder iconFinder = find.byIcon(FontAwesomeIcons.signOutAlt);
      expect(iconFinder, findsOneWidget);

      final iconColor = tester.widget<Icon>(iconFinder);
      expect(iconColor.color, primaryColour);

      final textFinder = find.text('Let\'s start with the basics...');
      expect(textFinder, findsOneWidget);
      final textStyle = tester.widget<Text>(textFinder);
      expect(textStyle.style?.color, secondaryColour);

      final Finder firstNameText = find.text('First name');
      expect(firstNameText, findsOneWidget);
      final Finder firstName = find.widgetWithText(TextFormField, 'First name');
      expect(firstName, findsOneWidget);

      final Finder lastNameText = find.text('Last name');
      expect(lastNameText, findsOneWidget);
      final Finder lastName = find.widgetWithText(TextFormField, 'Last name');
      expect(lastName, findsOneWidget);

      final Finder numberOfChipWidgets = find.byType(ChipWidget);
      expect(numberOfChipWidgets, findsWidgets);

      final Finder birthday = find.text('BIRTHDAY');
      expect(birthday, findsOneWidget);

      final Finder birthdaySelectButton = find.widgetWithText(ChipWidget, 'Select a date');

      expect(birthdaySelectButton, findsOneWidget);

      final Finder genderText = find.text('GENDER');
      expect(genderText, findsOneWidget);
      final Finder genderIcon = find.byType(Icon);
      expect(genderIcon, findsWidgets);

      final Finder relationshipStatus = find.text('RELATIONSHIP STATUS');
      expect(relationshipStatus, findsOneWidget);
      final Finder selectButton = find.widgetWithText(RelationshipStatusButton, 'Click to select');
      expect(selectButton, findsOneWidget);

      final Finder nextButton = find.widgetWithText(PillButtonFilled, 'Next');

      final nextButtonStyle = tester.widget<PillButtonFilled>(nextButton);
      expect(nextButtonStyle.text, 'Next');
      expect(nextButtonStyle.textStyle!.fontSize, 25);
      expect(nextButtonStyle.textStyle!.fontWeight, FontWeight.w600);
    });

    testWidgets("First and last name are prefilled if is available.", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-basic-info", testUser);

      expect(find.byType(RegisterBasicInfoScreen), findsOneWidget);

      final Finder firstNameFinder = find.widgetWithText(TextFormField, 'First name');
      expect(firstNameFinder, findsOneWidget);
      final TextFormField firstNameField = tester.widget<TextFormField>(firstNameFinder);

      final Finder lastNameFinder = find.widgetWithText(TextFormField, 'Last name');
      expect(lastNameFinder, findsOneWidget);
      final TextFormField lastNameField = tester.widget<TextFormField>(lastNameFinder);

      expect(firstNameField.controller?.text, testUser.firstName);
      expect(lastNameField.controller?.text, testUser.lastName);
    });

    testWidgets("textFormField only takes one value", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-basic-info", null);

      expect(find.byType(RegisterBasicInfoScreen), findsOneWidget);

      final Finder firstName = find.widgetWithText(TextFormField, 'First name');
      final Finder lastName = find.widgetWithText(TextFormField, 'Last name');

      await tester.enterText(firstName, 'Amy');
      await tester.enterText(lastName, 'Garcia');

      await tester.pump();

      expect(find.text('Amy'), findsOneWidget);
      expect(find.text('Garcia'), findsOneWidget);

      await tester.enterText(firstName, 'Peter');
      await tester.enterText(lastName, 'Parker');

      await tester.pump();

      expect(find.text('Amy'), findsNothing);
      expect(find.text('Garcia'), findsNothing);

      expect(find.text('Peter'), findsOneWidget);
      expect(find.text('Parker'), findsOneWidget);
    });

    testWidgets('Tapping back button returns normally', (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-basic-info", null);

      expect(find.byType(RegisterBasicInfoScreen), findsOneWidget);

      final Finder sliverAppBarFinder = find.byType(SliverAppBar);
      expect(sliverAppBarFinder, findsOneWidget);

      final Finder sliverAppBarLeadingButtonFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(IconButton));
      expect(sliverAppBarLeadingButtonFinder, findsOneWidget);
      final IconButton sliverAppBarLeadingButton = tester.widget<IconButton>(sliverAppBarLeadingButtonFinder);
      expect(sliverAppBarLeadingButton.onPressed, isNotNull);
      expect(() => sliverAppBarLeadingButton.onPressed!(), returnsNormally);
    });

    testWidgets("Date of birth onSave should return normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-basic-info", null);

      expect(find.byType(RegisterBasicInfoScreen), findsOneWidget);

      final Finder dateOfBirthButtonFinder = find.byType(DateOfBirthButton);
      expect(dateOfBirthButtonFinder, findsOneWidget);
      final DateOfBirthButton dateOfBirthButton = tester.widget<DateOfBirthButton>(dateOfBirthButtonFinder);
      expect(dateOfBirthButton.editable, true);
      expect(dateOfBirthButton.onSave, isNotNull);

      expect(() => dateOfBirthButton.onSave!(DateTime(1999, 1, 31)), returnsNormally);
    });

    testWidgets("Gender onSave should return normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-basic-info", null);

      expect(find.byType(RegisterBasicInfoScreen), findsOneWidget);

      final Finder genderChipRowFinder = find.byKey(const Key("genderRow"));
      final Finder genderChipFinder = find.descendant(of: genderChipRowFinder, matching: find.byType(ChipWidget));
      expect(genderChipFinder, findsNWidgets(3));
      final ChipWidget firstGenderChip = tester.widget<ChipWidget>(genderChipFinder.first);
      expect(firstGenderChip.onTap, isNotNull);

      expect(() => firstGenderChip.onTap!(), returnsNormally);
    });

    testWidgets("Relationship onSave should return normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-basic-info", null);

      expect(find.byType(RegisterBasicInfoScreen), findsOneWidget);

      final Finder relationshipStatusButtonFinder = find.byType(RelationshipStatusButton);
      expect(relationshipStatusButtonFinder, findsOneWidget);
      final RelationshipStatusButton relationshipStatusButton = tester.widget<RelationshipStatusButton>(relationshipStatusButtonFinder);
      expect(relationshipStatusButton.editable, true);
      expect(relationshipStatusButton.shouldExpand, true);
      expect(relationshipStatusButton.onSave, isNotNull);

      expect(() => relationshipStatusButton.onSave!("Single"), returnsNormally);
    });

    testWidgets("Tapping next button with no info inserted returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-basic-info", null);

      expect(find.byType(RegisterBasicInfoScreen), findsOneWidget);

      final Finder nextButtonFinder = find.widgetWithText(PillButtonFilled, 'Next');
      expect(nextButtonFinder, findsOneWidget);
      final PillButtonFilled nextButton = tester.widget<PillButtonFilled>(nextButtonFinder);
      expect(() => nextButton.onPressed(), returnsNormally);
    });

    testWidgets("Tapping next button with info inserted returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-basic-info", testUser);

      expect(find.byType(RegisterBasicInfoScreen), findsOneWidget);

      final Finder nextButtonFinder = find.widgetWithText(PillButtonFilled, 'Next');
      expect(nextButtonFinder, findsOneWidget);
      final PillButtonFilled nextButton = tester.widget<PillButtonFilled>(nextButtonFinder);
      expect(() => nextButton.onPressed(), returnsNormally);
    });
  });
}
