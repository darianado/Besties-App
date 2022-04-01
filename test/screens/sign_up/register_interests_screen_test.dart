import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/interests/select_interests.dart';
import 'package:project_seg/screens/sign_up/register_interests_screen.dart';
import 'package:project_seg/constants/colours.dart';
import '../../test_resources/helpers.dart';
import '../../test_resources/testing_data.dart';
import '../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;
  const String userEmail = "markdoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup("markdoe@example.org", authenticated: true);
  });

  group("Register interests screen:", () {
    testWidgets('interests page has all widgets', (WidgetTester tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-interests", null);

      final Finder iconButton = find.byType(Icon);
      expect(iconButton, findsOneWidget);
      final iconStyle = tester.widget<Icon>(iconButton);
      expect(iconStyle.color, primaryColour);

      final Finder textHeaderFinder = find.text('Finally, what do you like?');
      expect(textHeaderFinder, findsOneWidget);
      final textHeaderStyle = tester.widget<Text>(textHeaderFinder);
      expect(textHeaderStyle.style?.color, secondaryColour);

      final Finder textFinder = find.text("It is time to let us know more about your interests.");
      expect(textFinder, findsOneWidget);
      final textStyle = tester.widget<Text>(textFinder);
      expect(textStyle.textAlign, TextAlign.center);

      final Finder textParagraphFinder = find.byType(SliverFillRemaining);
      expect(textParagraphFinder, findsOneWidget);

      final Finder nextTextFinder = find.text('Done');
      expect(nextTextFinder, findsOneWidget);

      final Finder buttonFinder = find.widgetWithText(PillButtonFilled, 'Done');
      expect(buttonFinder, findsOneWidget);

      final buttonStyle = tester.widget<PillButtonFilled>(buttonFinder);
      expect(buttonStyle.text, 'Done');
      expect(buttonStyle.textStyle!.fontSize, 25);
      expect(buttonStyle.backgroundColor, tertiaryColour);
      expect(buttonStyle.textStyle!.fontWeight, FontWeight.w600);
    });

    testWidgets('Tapping back button returns normally', (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-interests", null);

      expect(find.byType(RegisterInterestsScreen), findsOneWidget);

      final Finder sliverAppBarFinder = find.byType(SliverAppBar);
      expect(sliverAppBarFinder, findsOneWidget);

      final Finder sliverAppBarLeadingButtonFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(IconButton));
      expect(sliverAppBarLeadingButtonFinder, findsOneWidget);
      final IconButton sliverAppBarLeadingButton = tester.widget<IconButton>(sliverAppBarLeadingButtonFinder);
      expect(sliverAppBarLeadingButton.onPressed, isNotNull);
      expect(() => sliverAppBarLeadingButton.onPressed!(), returnsNormally);
    });

    testWidgets("Tapping next button with nothing selected returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-interests", null);

      expect(find.byType(RegisterInterestsScreen), findsOneWidget);

      final Finder nextButtonFinder = find.widgetWithText(PillButtonFilled, 'Done');
      expect(nextButtonFinder, findsOneWidget);
      final PillButtonFilled nextButton = tester.widget<PillButtonFilled>(nextButtonFinder);
      expect(() => nextButton.onPressed(), returnsNormally);
    });

    testWidgets("Tapping next button with something selected returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-interests", testUser);

      expect(find.byType(RegisterInterestsScreen), findsOneWidget);

      final Finder nextButtonFinder = find.widgetWithText(PillButtonFilled, 'Done');
      expect(nextButtonFinder, findsOneWidget);
      final PillButtonFilled nextButton = tester.widget<PillButtonFilled>(nextButtonFinder);
      expect(() => nextButton.onPressed(), returnsNormally);
    });

    testWidgets("Changing selection to a valid selection and clicking 'done' returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-interests", testUser);

      expect(find.byType(RegisterInterestsScreen), findsOneWidget);

      final Finder selectInterestsFinder = find.byType(SelectInterests);
      expect(selectInterestsFinder, findsOneWidget);
      final SelectInterests selectInterests = tester.widget<SelectInterests>(selectInterestsFinder);

      expect(() => selectInterests.onChange(testUser.categorizedInterests!), returnsNormally);

      await tester.pump();

      final Finder nextButtonFinder = find.widgetWithText(PillButtonFilled, 'Done');
      expect(nextButtonFinder, findsOneWidget);
      final PillButtonFilled nextButton = tester.widget<PillButtonFilled>(nextButtonFinder);
      expect(() => nextButton.onPressed(), returnsNormally);
    });

    testWidgets("Changing selection to a invalid selection and clicking 'done' returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-interests", testUser);

      expect(find.byType(RegisterInterestsScreen), findsOneWidget);

      final Finder selectInterestsFinder = find.byType(SelectInterests);
      expect(selectInterestsFinder, findsOneWidget);
      final SelectInterests selectInterests = tester.widget<SelectInterests>(selectInterestsFinder);

      final invalidCategorizedInterests = CategorizedInterests(categories: []);

      expect(() => selectInterests.onChange(invalidCategorizedInterests), returnsNormally);

      await tester.pump();

      final Finder nextButtonFinder = find.widgetWithText(PillButtonFilled, 'Done');
      expect(nextButtonFinder, findsOneWidget);
      final PillButtonFilled nextButton = tester.widget<PillButtonFilled>(nextButtonFinder);
      expect(() => nextButton.onPressed(), returnsNormally);
    });
  });
}
