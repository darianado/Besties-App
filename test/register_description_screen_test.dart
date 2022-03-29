import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/sign_up/register_description_screen.dart';
import 'mock.dart';
import 'test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();
  UserData currentUserData = UserData(firstName: "Amy");

  setUpAll(() async {
    await _widgetPumper.setup();
  });

  testWidgets('Description page has all info widgets', (WidgetTester tester) async {
    await _widgetPumper.pumpWidget(tester, RegisterDescriptionScreen(userData: currentUserData));

    final Finder iconButton = find.byType(IconButton);
    expect(iconButton, findsOneWidget);

    final Finder textFinder = find.text('... and a bit more about Amy');
    expect(textFinder, findsOneWidget);

    final Finder universityFinder = find.text('UNIVERSITY');
    expect(universityFinder, findsOneWidget);

    final Finder universityFinderTextFinder = find.text('Select your university');
    expect(universityFinderTextFinder, findsOneWidget);

    final Finder universityWidgetFinder = find.byType(UniversityButton);
    expect(universityWidgetFinder, findsOneWidget);

    /* await tester.tap(find.widgetWithText(UniversityButton, 'Select your university'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(Chip, "King's College London"));
    await tester.pumpAndSettle();

    final Finder selectUniveristyWidgetTextFinder = find.text("King's College London");
    expect(selectUniveristyWidgetTextFinder, findsOneWidget); */

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

    final Finder nextButtonFinder = find.widgetWithText(ElevatedButton, 'Next');
    expect(nextButtonFinder, findsOneWidget);
  });
}
