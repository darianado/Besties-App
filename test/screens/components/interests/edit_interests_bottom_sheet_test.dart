import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/interests/edit_interests_bottom_sheet.dart';

import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  Category category = Category(
    title: "Sample",
    interests: [
      Interest(title: "One"),
      Interest(title: "Two"),
      Interest(title: "Three"),
      Interest(title: "Four"),
      Interest(title: "Five"),
    ],
  );

  Category selected = Category(
    title: "Sample",
    interests: [
      Interest(title: "One"),
      Interest(title: "Two"),
    ],
  );

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group("Edit interests bottom sheet:", () {
    testWidgets('Food category for John interest category View', (WidgetTester tester) async {
      await _widgetPumper.pumpWidget(
          tester,
          EditInterestBottomSheet(
            category: category,
            selected: selected,
            onChange: (newCategory) {},
          ));

      final Finder categoryTitleTextFinder = find.text("Sample");
      expect(categoryTitleTextFinder, findsOneWidget);

      final Finder interestOneFinder = find.widgetWithText(ChipWidget, "One");
      expect(interestOneFinder, findsOneWidget);

      final interestOne = tester.widget<ChipWidget>(interestOneFinder);
      expect(interestOne.color, tertiaryColour);
      expect(interestOne.bordered, false);
      expect(interestOne.textColor, simpleWhiteColour);
      expect(interestOne.label, "One");

      final Finder interestTwoFinder = find.widgetWithText(ChipWidget, "Two");
      expect(interestTwoFinder, findsOneWidget);

      final Finder interestThreeFinder = find.widgetWithText(ChipWidget, "Three");
      expect(interestThreeFinder, findsOneWidget);

      final interestThree = tester.widget<ChipWidget>(interestThreeFinder);
      expect(interestThree.color, tertiaryColour);
      expect(interestThree.bordered, true);
      expect(interestThree.label, "Three");

      final Finder saveButton = find.widgetWithText(PillButtonFilled, 'Save');
      expect(saveButton, findsOneWidget);
      final saveButtonStyle = tester.widget<PillButtonFilled>(saveButton);
      expect(saveButtonStyle.backgroundColor, secondaryColour);
      expect(saveButtonStyle.text, 'Save');
      expect(saveButtonStyle.textStyle!.fontSize, 18);
      expect(saveButtonStyle.textStyle!.fontWeight, FontWeight.w600);
      expect(saveButtonStyle.textStyle!.color, whiteColour);
    });

    testWidgets('Tapping selected chip returns normally', (WidgetTester tester) async {
      await _widgetPumper.pumpWidget(
          tester,
          EditInterestBottomSheet(
            category: category,
            selected: selected,
            onChange: (newCategory) {},
          ));

      final Finder categoryTitleTextFinder = find.text("Sample");
      expect(categoryTitleTextFinder, findsOneWidget);

      final Finder interestOneFinder = find.widgetWithText(ChipWidget, "One");
      expect(interestOneFinder, findsOneWidget);

      final interestOne = tester.widget<ChipWidget>(interestOneFinder);
      expect(interestOne.onTap, isNotNull);

      expect(() => interestOne.onTap!(), returnsNormally);
    });

    testWidgets('Tapping unselected chip returns normally', (WidgetTester tester) async {
      await _widgetPumper.pumpWidget(
          tester,
          EditInterestBottomSheet(
            category: category,
            selected: selected,
            onChange: (newCategory) {},
          ));

      final Finder categoryTitleTextFinder = find.text("Sample");
      expect(categoryTitleTextFinder, findsOneWidget);

      final Finder interestOneFinder = find.widgetWithText(ChipWidget, "Three");
      expect(interestOneFinder, findsOneWidget);

      final interestOne = tester.widget<ChipWidget>(interestOneFinder);
      expect(interestOne.onTap, isNotNull);

      expect(() => interestOne.onTap!(), returnsNormally);
    });

    testWidgets('Tapping save button returns normally', (WidgetTester tester) async {
      await _widgetPumper.pumpWidget(
          tester,
          EditInterestBottomSheet(
            category: category,
            selected: selected,
            onChange: (newCategory) {},
          ));

      final Finder categoryTitleTextFinder = find.text("Sample");
      expect(categoryTitleTextFinder, findsOneWidget);

      final Finder saveButtonFinder = find.widgetWithText(PillButtonFilled, 'Save');
      expect(saveButtonFinder, findsOneWidget);
      final saveButton = tester.widget<PillButtonFilled>(saveButtonFinder);

      expect(() => saveButton.onPressed(), returnsNormally);
    });
  });
}
