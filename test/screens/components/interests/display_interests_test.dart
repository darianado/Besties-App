import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import '../../../test_resources/widget_pumper.dart';
import '../../../test_resources/test_profile.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  OtherUser currentUser = TestProfile.firstProfile;
  testWidgets('interests view', (WidgetTester tester) async {
    CategorizedInterests selected = currentUser.userData.categorizedInterests!;

    await _widgetPumper.pumpWidget(tester, DisplayInterests(interests: selected));

    final Wrap wrapWidgetFinder = tester.widget<Wrap>(find.byType(Wrap));

    expect(wrapWidgetFinder.alignment, WrapAlignment.center);
    expect(wrapWidgetFinder.runAlignment, WrapAlignment.center);
    expect(wrapWidgetFinder.spacing, 6.0);
    expect(wrapWidgetFinder.runSpacing, 6.0);

    final Finder cocktailsWidgetFinder = find.widgetWithText(ChipWidget, "Cocktails");
    expect(cocktailsWidgetFinder, findsOneWidget);

    final cocktailsWidgetStyle = tester.widget<ChipWidget>(cocktailsWidgetFinder);
    expect(cocktailsWidgetStyle.color, tertiaryColour);
    expect(cocktailsWidgetStyle.bordered, false);
    expect(cocktailsWidgetStyle.capitalizeLabel, true);
    expect(cocktailsWidgetStyle.textColor, whiteColour);
    expect(cocktailsWidgetStyle.label, "Cocktails");

    final Finder brunchWidgetFinder = find.widgetWithText(ChipWidget, "Brunch");
    expect(brunchWidgetFinder, findsOneWidget);

    final brunchWidgetStyle = tester.widget<ChipWidget>(brunchWidgetFinder);
    expect(brunchWidgetStyle.color, tertiaryColour);
    expect(brunchWidgetStyle.bordered, false);
    expect(brunchWidgetStyle.capitalizeLabel, true);
    expect(brunchWidgetStyle.textColor, whiteColour);
    expect(brunchWidgetStyle.label, "Brunch");

    final Finder coffeeWidgetFinder = find.widgetWithText(ChipWidget, "Coffee");
    expect(coffeeWidgetFinder, findsOneWidget);

    final coffeeWidgetStyle = tester.widget<ChipWidget>(coffeeWidgetFinder);
    expect(coffeeWidgetStyle.color, tertiaryColour);
    expect(coffeeWidgetStyle.bordered, false);
    expect(coffeeWidgetStyle.capitalizeLabel, true);
    expect(coffeeWidgetStyle.textColor, whiteColour);
    expect(coffeeWidgetStyle.label, "Coffee");

    final Finder hikingWidgetFinder = find.widgetWithText(ChipWidget, "Hiking");
    expect(hikingWidgetFinder, findsOneWidget);

    final hikingWidgetStyle = tester.widget<ChipWidget>(hikingWidgetFinder);
    expect(hikingWidgetStyle.color, tertiaryColour);
    expect(hikingWidgetStyle.bordered, false);
    expect(hikingWidgetStyle.capitalizeLabel, true);
    expect(hikingWidgetStyle.textColor, whiteColour);
    expect(hikingWidgetStyle.label, "Hiking");

    final Finder swimmingWidgetFinder = find.widgetWithText(ChipWidget, "Swimming");
    expect(swimmingWidgetFinder, findsOneWidget);

    final swimmingWidgetStyle = tester.widget<ChipWidget>(swimmingWidgetFinder);
    expect(swimmingWidgetStyle.color, tertiaryColour);
    expect(swimmingWidgetStyle.bordered, false);
    expect(swimmingWidgetStyle.capitalizeLabel, true);
    expect(swimmingWidgetStyle.textColor, whiteColour);
    expect(swimmingWidgetStyle.label, "Swimming");
  });


}
