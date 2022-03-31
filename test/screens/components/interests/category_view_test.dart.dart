import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/interests/category_view.dart';
import 'package:project_seg/constants/colours.dart';
import '../../../test_resources/widget_pumper.dart';
import '../../../test_resources/test_profile.dart';

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

  testWidgets('CategoryView', (WidgetTester tester) async {
    await _widgetPumper.pumpWidget(tester, CategoryView(category: category, selected: selected, onTap: () {}));

    final Finder titleFinder = find.text("food");
    expect(titleFinder, findsOneWidget);

    final Text titleText = tester.widget<Text>(titleFinder);
    expect(titleText.style?.fontSize, 20);

    final Finder iconFinder = find.byIcon(Icons.arrow_downward);
    expect(iconFinder, findsOneWidget);

    final Finder cocktailsWidgetFinder = find.widgetWithText(ChipWidget, "Cocktails");
    expect(cocktailsWidgetFinder, findsOneWidget);

    final cocktailsWidgetStyle = tester.widget<ChipWidget>(cocktailsWidgetFinder);
    expect(cocktailsWidgetStyle.color, tertiaryColour);
    expect(cocktailsWidgetStyle.bordered, false);
    expect(cocktailsWidgetStyle.textColor, simpleWhiteColour);
    expect(cocktailsWidgetStyle.label, "Cocktails");

    final Finder brunchWidgetFinder = find.widgetWithText(ChipWidget, "Brunch");
    expect(brunchWidgetFinder, findsOneWidget);

    final brunchWidgetStyle = tester.widget<ChipWidget>(brunchWidgetFinder);
    expect(brunchWidgetStyle.color, tertiaryColour);
    expect(brunchWidgetStyle.bordered, false);
    expect(brunchWidgetStyle.textColor, simpleWhiteColour);
    expect(brunchWidgetStyle.label, "Brunch");

    final Finder coffeeWidgetFinder = find.widgetWithText(ChipWidget, "Coffee");
    expect(coffeeWidgetFinder, findsOneWidget);

    final coffeeWidgetStyle = tester.widget<ChipWidget>(coffeeWidgetFinder);
    expect(coffeeWidgetStyle.color, tertiaryColour);
    expect(coffeeWidgetStyle.bordered, false);
    expect(coffeeWidgetStyle.textColor, simpleWhiteColour);
    expect(coffeeWidgetStyle.label, "Coffee");

    final Finder veganWidgetFinder = find.widgetWithText(ChipWidget, "Vegan");
    expect(veganWidgetFinder, findsOneWidget);

    final veganWidgetStyle = tester.widget<ChipWidget>(veganWidgetFinder);
    expect(veganWidgetStyle.color, tertiaryColour);
    expect(veganWidgetStyle.bordered, true);
    expect(veganWidgetStyle.textColor, simpleWhiteColour);
    expect(veganWidgetStyle.label, "Vegan");

    final Finder bakingWidgetFinder = find.widgetWithText(ChipWidget, "Baking");
    expect(bakingWidgetFinder, findsOneWidget);

    final bakingWidgetStyle = tester.widget<ChipWidget>(bakingWidgetFinder);
    expect(bakingWidgetStyle.color, tertiaryColour);
    expect(bakingWidgetStyle.bordered, true);
    expect(bakingWidgetStyle.label, "Baking");

    final Finder teaWidgetFinder = find.widgetWithText(ChipWidget, "Tea");
    expect(teaWidgetFinder, findsNothing);

    final teaWidgetStyle = tester.widget<ChipWidget>(teaWidgetFinder);
    expect(teaWidgetStyle.color, tertiaryColour);
    expect(teaWidgetStyle.bordered, true);
    expect(teaWidgetStyle.label, "Tea");
  });
}
