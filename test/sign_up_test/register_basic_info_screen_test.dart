import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../mock.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/constants/colours.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();
  UserData currentUserData = UserData();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  testWidgets('basic sign up page has all the field widgets', (WidgetTester tester) async {
    await _widgetPumper.pumpWidget(tester, RegisterBasicInfoScreen(userData: currentUserData));

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

    final Finder nextText = find.text('Next');
    expect(nextText, findsOneWidget);
    final Finder nextButton = find.widgetWithText(ElevatedButton, 'Next');
    expect(nextButton, findsOneWidget);

    final buttonTextStyle = tester.widget<Text>(nextText);
    expect(buttonTextStyle.style?.fontSize, 25);
    expect(buttonTextStyle.style?.fontWeight, FontWeight.w600);

    expect(find.byType(TextField), findsWidgets);
    expect(find.widgetWithText(TextField, 'First name'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Last name'), findsOneWidget);

    //text field only takes one value
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
}
