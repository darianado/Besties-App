import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import '../../../test_resources/widget_pumper.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/constants/colours.dart';
import '../../../test_resources/test_profile.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/screens/components/interests/edit_interests_bottom_sheet.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  OtherUser currentUser = TestProfile.firstProfile;
  Category selected = currentUser.userData.preferences!.interests!.categories[0];

  Category category = Category(
    title: "food",
    interests: [
      Interest(title: "Cocktails"),
      Interest(title: "Brunch"),
      Interest(title: "Vegan"),
      Interest(title: "Baking"),
      Interest(title: "Coffee"),
      Interest(title: "Tea"),
    ],
  );
  testWidgets('Food category for John interest category View', (WidgetTester tester) async {
    await _widgetPumper.pumpWidget(
        tester,
        EditInterestBottomSheet(
            category: category,
            selected: selected,
            onChange: (newCategory) {
              selected = newCategory;
            }));

    final Finder categoryTitleTextFinder = find.text("food");
    expect(categoryTitleTextFinder, findsOneWidget);

    final Finder cocktailsWidgetFinder = find.widgetWithText(ChipWidget, "Cocktails");
    expect(cocktailsWidgetFinder, findsOneWidget);

    final cocktailsWidgetStyle = tester.widget<ChipWidget>(cocktailsWidgetFinder);
    expect(cocktailsWidgetStyle.color, tertiaryColour);
    expect(cocktailsWidgetStyle.bordered, false);
    expect(cocktailsWidgetStyle.textColor, simpleWhiteColour);
    expect(cocktailsWidgetStyle.label, "Cocktails");

    final Finder brunchWidgetFinder = find.widgetWithText(ChipWidget, "Brunch");
    expect(brunchWidgetFinder, findsOneWidget);

    final Finder veganWidgetFinder = find.widgetWithText(ChipWidget, "Vegan");
    expect(veganWidgetFinder, findsOneWidget);

    final Finder bakingWidgetFinder = find.widgetWithText(ChipWidget, "Baking");
    expect(bakingWidgetFinder, findsOneWidget);

    final Finder coffeeWidgetFinder = find.widgetWithText(ChipWidget, "Coffee");
    expect(coffeeWidgetFinder, findsOneWidget);

    final Finder teaWidgetFinder = find.widgetWithText(ChipWidget, "Tea");
    expect(teaWidgetFinder, findsOneWidget);

    final teaWidgetStyle = tester.widget<ChipWidget>(teaWidgetFinder);
    expect(teaWidgetStyle.color, tertiaryColour);
    expect(teaWidgetStyle.bordered, true);
    expect(teaWidgetStyle.label, "Tea");

    final Finder saveButton = find.widgetWithText(PillButtonFilled, 'Save');
    expect(saveButton, findsOneWidget);
    final saveButtonStyle = tester.widget<PillButtonFilled>(saveButton);
    expect(saveButtonStyle.backgroundColor, secondaryColour);
    expect(saveButtonStyle.text, 'Save');
    expect(saveButtonStyle.textStyle!.fontSize, 18);
    expect(saveButtonStyle.textStyle!.fontWeight, FontWeight.w600);
    expect(saveButtonStyle.textStyle!.color, whiteColour);
  });


}
