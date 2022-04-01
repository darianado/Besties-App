import 'package:project_seg/constants/colours.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/sign_up/register_description_screen.dart';
import '../../test_resources/helpers.dart';
import '../../test_resources/testing_data.dart';
import '../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;
  const String userEmail = "markdoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group("Register description screen:", () {
    testWidgets('Contains required information', (WidgetTester tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-description", UserData(firstName: "Amy"));

      expect(find.byType(RegisterDescriptionScreen), findsOneWidget);

      final Finder iconButton = find.byType(IconButton);
      expect(iconButton, findsOneWidget);

      final Finder textFinder = find.text('... and a bit more about Amy');
      expect(textFinder, findsOneWidget);
      final textStyle = tester.widget<Text>(textFinder);
      expect(textStyle.style?.color, secondaryColour);

      final Finder universityFinder = find.text('UNIVERSITY');
      expect(universityFinder, findsOneWidget);

      final Finder universityFinderTextFinder = find.text('Select your university');
      expect(universityFinderTextFinder, findsOneWidget);

      final Finder universityWidgetFinder = find.byType(UniversityButton);
      expect(universityWidgetFinder, findsOneWidget);
      final univeristyWidgetStyle = tester.widget<UniversityButton>(universityWidgetFinder);
      expect(univeristyWidgetStyle.color, secondaryColour);
      expect(univeristyWidgetStyle.label, "Select your university");

      final Finder bioTextFinder = find.text('BIO / SHORT DESCRIPTION');
      expect(bioTextFinder, findsOneWidget);

      final Finder bioWidgetFinder = find.widgetWithText(TextFormField, 'Enter your bio here...');
      expect(bioWidgetFinder, findsOneWidget);

      await tester.enterText(bioWidgetFinder, "This is my bio.");
      await tester.pumpAndSettle();

      final Finder textBioWidgetFinder = find.widgetWithText(TextFormField, "This is my bio.");
      expect(textBioWidgetFinder, findsOneWidget);

      final Finder nextTextFinder = find.text('Next');
      expect(nextTextFinder, findsOneWidget);

      final Finder nextButton = find.widgetWithText(PillButtonFilled, 'Next');

      final nextButtonStyle = tester.widget<PillButtonFilled>(nextButton);
      expect(nextButtonStyle.text, 'Next');
      expect(nextButtonStyle.textStyle!.fontSize, 25);
      expect(nextButtonStyle.textStyle!.fontWeight, FontWeight.w600);
    });

    testWidgets("Bio is prefilled if text is available.", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-description", testUser);

      expect(find.byType(RegisterDescriptionScreen), findsOneWidget);

      final Finder bioTextFieldFinder = find.widgetWithText(TextFormField, 'Enter your bio here...');
      expect(bioTextFieldFinder, findsOneWidget);
      final TextFormField bioTextField = tester.widget<TextFormField>(bioTextFieldFinder);
      expect(bioTextField.controller?.text, testUser.bio);
    });

    testWidgets('Tapping back button returns normally', (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-description", null);

      expect(find.byType(RegisterDescriptionScreen), findsOneWidget);

      final Finder sliverAppBarFinder = find.byType(SliverAppBar);
      expect(sliverAppBarFinder, findsOneWidget);

      final Finder sliverAppBarLeadingButtonFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(IconButton));
      expect(sliverAppBarLeadingButtonFinder, findsOneWidget);
      final IconButton sliverAppBarLeadingButton = tester.widget<IconButton>(sliverAppBarLeadingButtonFinder);
      expect(sliverAppBarLeadingButton.onPressed, isNotNull);
      expect(() => sliverAppBarLeadingButton.onPressed!(), returnsNormally);
    });

    testWidgets("University onSave should return normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-description", null);

      expect(find.byType(RegisterDescriptionScreen), findsOneWidget);

      final Finder universityButtonFinder = find.byType(UniversityButton);
      expect(universityButtonFinder, findsOneWidget);
      final UniversityButton universityButton = tester.widget<UniversityButton>(universityButtonFinder);
      expect(universityButton.editable, true);
      expect(universityButton.onSave, isNotNull);

      expect(() => universityButton.onSave!("King's College London"), returnsNormally);
    });

    testWidgets("Tapping next button with nothing selected returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-description", null);

      expect(find.byType(RegisterDescriptionScreen), findsOneWidget);

      final Finder nextButtonFinder = find.widgetWithText(PillButtonFilled, 'Next');
      expect(nextButtonFinder, findsOneWidget);
      final PillButtonFilled nextButton = tester.widget<PillButtonFilled>(nextButtonFinder);
      expect(() => nextButton.onPressed(), returnsNormally);
    });

    testWidgets("Tapping next button with valid data returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-description", testUser);

      expect(find.byType(RegisterDescriptionScreen), findsOneWidget);

      final Finder nextButtonFinder = find.widgetWithText(PillButtonFilled, 'Next');
      expect(nextButtonFinder, findsOneWidget);
      final PillButtonFilled nextButton = tester.widget<PillButtonFilled>(nextButtonFinder);
      expect(() => nextButton.onPressed(), returnsNormally);
    });
  });
}
