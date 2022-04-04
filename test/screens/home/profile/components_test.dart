import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';

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

  group('ProfileInformation widget tests', () {
    group("SliverAppBar:", () {
      testWidgets("No actions", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester, ProfileInformation(editable: true, userData: testUser));

        final Finder sliverAppBarFinder = find.byType(SliverAppBar);
        expect(sliverAppBarFinder, findsOneWidget);

        final Finder sliverAppBarActionRowFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(Row));
        expect(sliverAppBarActionRowFinder, findsOneWidget);
        final Row sliverAppBarActionRow = tester.widget<Row>(sliverAppBarActionRowFinder);
        expect(sliverAppBarActionRow.children, containsAll([isA<Container>(), isA<Container>()]));
      });

      testWidgets("Left action", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester, ProfileInformation(editable: true, userData: testUser, leftAction: const Text("Hello")));

        final Finder sliverAppBarFinder = find.byType(SliverAppBar);
        expect(sliverAppBarFinder, findsOneWidget);

        final Finder sliverAppBarActionRowFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(Row));
        expect(sliverAppBarActionRowFinder, findsOneWidget);
        final Row sliverAppBarActionRow = tester.widget<Row>(sliverAppBarActionRowFinder);
        expect(sliverAppBarActionRow.children, containsAll([isA<Text>(), isA<Container>()]));
      });

      testWidgets("Right action", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester, ProfileInformation(editable: true, userData: testUser, rightAction: const Text("Hello")));

        final Finder sliverAppBarFinder = find.byType(SliverAppBar);
        expect(sliverAppBarFinder, findsOneWidget);

        final Finder sliverAppBarActionRowFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(Row));
        expect(sliverAppBarActionRowFinder, findsOneWidget);
        final Row sliverAppBarActionRow = tester.widget<Row>(sliverAppBarActionRowFinder);
        expect(sliverAppBarActionRow.children, containsAll([isA<Container>(), isA<Text>()]));
      });

      testWidgets("Both actions", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester,
            ProfileInformation(editable: true, userData: testUser, leftAction: const Text("Left"), rightAction: const Text("Right")));

        final Finder sliverAppBarFinder = find.byType(SliverAppBar);
        expect(sliverAppBarFinder, findsOneWidget);

        final Finder sliverAppBarActionRowFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(Row));
        expect(sliverAppBarActionRowFinder, findsOneWidget);
        final Row sliverAppBarActionRow = tester.widget<Row>(sliverAppBarActionRowFinder);
        expect(sliverAppBarActionRow.children, containsAll([isA<Text>(), isA<Text>()]));
      });

      testWidgets("Edit profile function returns normally", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester, ProfileInformation(editable: true, userData: testUser));

        final Finder sliverAppBarFinder = find.byType(SliverAppBar);
        expect(sliverAppBarFinder, findsOneWidget);

        final Finder sliverAppBarInkWellFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(InkWell));
        expect(sliverAppBarInkWellFinder, findsOneWidget);
        final InkWell sliverAppBarInkWell = tester.widget<InkWell>(sliverAppBarInkWellFinder);
        expect(sliverAppBarInkWell.onTap, isNotNull);
        expect(() => sliverAppBarInkWell.onTap!(), returnsNormally);
      });
    });

    group("SliverFillRemaining:", () {
      testWidgets("University button exists and behaves as expected", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester, ProfileInformation(editable: true, userData: testUser));

        final Finder sliverFillRemainingFinder = find.byType(SliverFillRemaining);
        expect(sliverFillRemainingFinder, findsOneWidget);

        final Finder universityButtonFinder = find.descendant(of: sliverFillRemainingFinder, matching: find.byType(UniversityButton));
        expect(universityButtonFinder, findsOneWidget);
        final UniversityButton universityButton = tester.widget<UniversityButton>(universityButtonFinder);
        expect(universityButton.editable, true);
        expect(universityButton.onSave, isNotNull);

        expect(() => universityButton.onSave!("King's College London"), returnsNormally);
      });

      testWidgets("DateOfBirth button exists and behaves as expected", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester, ProfileInformation(editable: true, userData: testUser));

        final Finder sliverFillRemainingFinder = find.byType(SliverFillRemaining);
        expect(sliverFillRemainingFinder, findsOneWidget);

        final Finder dateOfBirthButtonFinder = find.descendant(of: sliverFillRemainingFinder, matching: find.byType(DateOfBirthButton));
        expect(dateOfBirthButtonFinder, findsOneWidget);
        final DateOfBirthButton dateOfBirthButton = tester.widget<DateOfBirthButton>(dateOfBirthButtonFinder);
        expect(dateOfBirthButton.editable, false);
        expect(dateOfBirthButton.onSave, isNull);
      });

      testWidgets("Gender button exists and behaves as expected", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester, ProfileInformation(editable: true, userData: testUser));

        final Finder sliverFillRemainingFinder = find.byType(SliverFillRemaining);
        expect(sliverFillRemainingFinder, findsOneWidget);

        final Finder genderButtonFinder = find.descendant(of: sliverFillRemainingFinder, matching: find.byType(GenderButton));
        expect(genderButtonFinder, findsOneWidget);
        final GenderButton genderButton = tester.widget<GenderButton>(genderButtonFinder);
        expect(genderButton.editable, true);
        expect(genderButton.onSave, isNotNull);

        expect(() => genderButton.onSave!("female"), returnsNormally);
      });

      testWidgets("Relationship status button exists and behaves as expected", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester, ProfileInformation(editable: true, userData: testUser));

        final Finder sliverFillRemainingFinder = find.byType(SliverFillRemaining);
        expect(sliverFillRemainingFinder, findsOneWidget);

        final Finder relationshipStatusButtonFinder =
            find.descendant(of: sliverFillRemainingFinder, matching: find.byType(RelationshipStatusButton));
        expect(relationshipStatusButtonFinder, findsOneWidget);
        final RelationshipStatusButton relationshipStatusButton = tester.widget<RelationshipStatusButton>(relationshipStatusButtonFinder);
        expect(relationshipStatusButton.editable, true);
        expect(relationshipStatusButton.onSave, isNotNull);

        expect(() => relationshipStatusButton.onSave!("Single"), returnsNormally);
      });

      testWidgets("Display interests exists and behaves as expected", (tester) async {
        await signInHelper(_widgetPumper, userEmail);
        await _widgetPumper.pumpWidget(tester, ProfileInformation(editable: true, userData: testUser));

        final Finder sliverFillRemainingFinder = find.byType(SliverFillRemaining);
        expect(sliverFillRemainingFinder, findsOneWidget);

        final Finder displayInterestsFinder = find.descendant(of: sliverFillRemainingFinder, matching: find.byType(DisplayInterests));
        expect(displayInterestsFinder, findsOneWidget);
        final DisplayInterests displayInterests = tester.widget<DisplayInterests>(displayInterestsFinder);
        expect(displayInterests.editable, true);
        expect(displayInterests.onSave, isNotNull);

        expect(() => displayInterests.onSave!(testUser.categorizedInterests!), returnsNormally);
      });
    });
  });
}
