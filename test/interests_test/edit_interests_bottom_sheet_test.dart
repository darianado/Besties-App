import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import '../test_resources/widget_pumper.dart';
import '../test_resources/test_profile.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/constants/colours.dart';
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

  Category selected = currentUser.userData.categorizedInterests!.categories.first;



  Category category = Category(
    title: "food",
    interests: [
      Interest(title: "Cocktails"),
      Interest(title: "Brunch"),
      Interest(title: "Coffee"),
      Interest(title: "Tea"),
    ],
  );

  testWidgets('first interest category View', (WidgetTester tester) async {

    await _widgetPumper.pumpWidget(tester, 
        EditInterestBottomSheet(
          category: category, 
          selected: selected, 
          onChange: (newCategory) 
            {
              selected = newCategory;
            }
        )
    );

    final Finder firstInterestTextFinder = find.text("Cocktails");
    expect(firstInterestTextFinder, findsOneWidget);

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

    final Finder fourthInterestWidgetFinder = find.widgetWithText(ChipWidget, "Tea");
    expect(fourthInterestWidgetFinder, findsOneWidget);

    final fourthInterestWidgetStyle = tester.widget<ChipWidget>(fourthInterestWidgetFinder);
    expect(fourthInterestWidgetStyle.color, tertiaryColour);
    expect(fourthInterestWidgetStyle.bordered, true);
    expect(fourthInterestWidgetStyle.label, "Tea");

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
