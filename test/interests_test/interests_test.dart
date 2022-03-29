import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/interests/category_view.dart';
import 'package:project_seg/constants/colours.dart';
import '../test_resources/widget_pumper.dart';
import '../test_resources/test_profile.dart';
import 'package:firebase_core/firebase_core.dart';
import '../mock.dart';

//import 'test_resources/WidgetPumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup();
  });

  OtherUser currentUser = TestProfile.firstProfile;

  Category selected = currentUser.userData.categorizedInterests!.categories[0];

  Category category = Category(
    title: "food",
    interests: [
      Interest(title: "Cocktails"),
      Interest(title: "Brunch"),
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

    final Finder firstInterestWidgetFinder = find.widgetWithText(ChipWidget, "Cocktails");
    expect(firstInterestWidgetFinder, findsOneWidget);

    final firstInterestWidgetStyle = tester.widget<ChipWidget>(firstInterestWidgetFinder);
    expect(firstInterestWidgetStyle.color, tertiaryColour);
    expect(firstInterestWidgetStyle.bordered, false);
    expect(firstInterestWidgetStyle.textColor, simpleWhiteColour);
    expect(firstInterestWidgetStyle.label, "Cocktails");

    final Finder secondInterestWidgetFinder = find.widgetWithText(ChipWidget, "Brunch");
    expect(secondInterestWidgetFinder, findsOneWidget);

    final secondInterestWidgetStyle = tester.widget<ChipWidget>(secondInterestWidgetFinder);
    expect(secondInterestWidgetStyle.color, tertiaryColour);
    expect(secondInterestWidgetStyle.bordered, false);
    expect(secondInterestWidgetStyle.textColor, simpleWhiteColour);
    expect(secondInterestWidgetStyle.label, "Brunch");

    final Finder thirdInterestWidgetFinder = find.widgetWithText(ChipWidget, "Coffee");
    expect(thirdInterestWidgetFinder, findsOneWidget);

    final thirdInterestWidgetStyle = tester.widget<ChipWidget>(thirdInterestWidgetFinder);
    expect(thirdInterestWidgetStyle.color, tertiaryColour);
    expect(thirdInterestWidgetStyle.bordered, false);
    expect(thirdInterestWidgetStyle.textColor, simpleWhiteColour);
    expect(thirdInterestWidgetStyle.label, "Coffee");

    final Finder fourthInterestWidgetFinder = find.widgetWithText(ChipWidget, "Tea");
    expect(fourthInterestWidgetFinder, findsNothing);
  });
}
