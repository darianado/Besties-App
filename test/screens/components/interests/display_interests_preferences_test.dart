import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import '../../../test_resources/widget_pumper.dart';
import '../../../test_resources/test_profile.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/interests/display_interests_preferences.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  OtherUser currentUser = TestProfile.firstProfile;


  testWidgets('first preference interest category View', (WidgetTester tester) async {
    Category selected = currentUser.userData.preferences!.interests!.categories[0];

    await _widgetPumper.pumpWidget(tester, DisplayInterestsPreferences(items: selected.interests));

    final Wrap wrapWidgetFinder = tester.widget<Wrap>(find.byType(Wrap));

    expect(wrapWidgetFinder.alignment, WrapAlignment.center);
    expect(wrapWidgetFinder.runAlignment, WrapAlignment.center);
    expect(wrapWidgetFinder.spacing, 6.0);
    expect(wrapWidgetFinder.runSpacing, 6.0);

    final Finder cocktailsInterestWidgetFinder = find.widgetWithText(ChipWidget, "Cocktails");
    expect(cocktailsInterestWidgetFinder, findsOneWidget);

    final cocktailsInterestWidgetStyle = tester.widget<ChipWidget>(cocktailsInterestWidgetFinder);
    expect(cocktailsInterestWidgetStyle.color, tertiaryColour);
    expect(cocktailsInterestWidgetStyle.bordered, false);
    expect(cocktailsInterestWidgetStyle.textColor, simpleWhiteColour);
    expect(cocktailsInterestWidgetStyle.label, "Cocktails");

    final Finder brunchWidgetFinder = find.widgetWithText(ChipWidget, "Brunch");
    expect(brunchWidgetFinder, findsOneWidget);

    final brunchWidgetStyle = tester.widget<ChipWidget>(brunchWidgetFinder);
    expect(brunchWidgetStyle.color, tertiaryColour);
    expect(brunchWidgetStyle.bordered, false);
    expect(brunchWidgetStyle.textColor, simpleWhiteColour);
    expect(brunchWidgetStyle.label, "Brunch");

    final Finder coffeeWidgetFinder = find.widgetWithText(ChipWidget, "Coffee");
    expect(coffeeWidgetFinder, findsNothing);

    final Finder hikingWidgetFinder = find.widgetWithText(ChipWidget, "Hiking");
    expect(hikingWidgetFinder, findsNothing);

    final Finder swimmingWidgetFinder = find.widgetWithText(ChipWidget, "Swimming");
    expect(swimmingWidgetFinder, findsNothing);

  });

  testWidgets('sports preference interest category View', (WidgetTester tester) async {
    Category selected = currentUser.userData.preferences!.interests!.categories[1];

    await _widgetPumper.pumpWidget(tester, DisplayInterestsPreferences(items: selected.interests));

    final Wrap wrapWidgetFinder = tester.widget<Wrap>(find.byType(Wrap));

    expect(wrapWidgetFinder.alignment, WrapAlignment.center);
    expect(wrapWidgetFinder.runAlignment, WrapAlignment.center);
    expect(wrapWidgetFinder.spacing, 6.0);
    expect(wrapWidgetFinder.runSpacing, 6.0);

    final Finder cocktailsWidgetFinder = find.widgetWithText(ChipWidget, "Cocktails");
    expect(cocktailsWidgetFinder, findsNothing);

    final Finder brunchWidgetFinder = find.widgetWithText(ChipWidget, "Brunch");
    expect(brunchWidgetFinder, findsNothing);

    final Finder coffeeWidgetFinder = find.widgetWithText(ChipWidget, "Coffee");
    expect(coffeeWidgetFinder, findsNothing);

    final Finder hikingWidgetFinder = find.widgetWithText(ChipWidget, "Hiking");
    expect(hikingWidgetFinder, findsOneWidget);

    final hikingWidgetStyle = tester.widget<ChipWidget>(hikingWidgetFinder);
    expect(hikingWidgetStyle.color, tertiaryColour);
    expect(hikingWidgetStyle.bordered, false);
    expect(hikingWidgetStyle.textColor, simpleWhiteColour);
    expect(hikingWidgetStyle.label, "Hiking");

    final Finder swimmingWidgetFinder = find.widgetWithText(ChipWidget, "Swimming");
    expect(swimmingWidgetFinder, findsNothing);

  });
}
