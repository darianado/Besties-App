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
  testWidgets('first interest category View', (WidgetTester tester) async {
    CategorizedInterests selected = currentUser.userData.categorizedInterests!;

    await _widgetPumper.pumpWidget(tester, DisplayInterests(interests: selected));

    final Wrap wrapWidgetFinder = tester.widget<Wrap>(find.byType(Wrap));

    expect(wrapWidgetFinder.alignment, WrapAlignment.center);
    expect(wrapWidgetFinder.runAlignment, WrapAlignment.center);
    expect(wrapWidgetFinder.spacing, 6.0);
    expect(wrapWidgetFinder.runSpacing, 6.0);

    final Finder firstInterestWidgetFinder = find.widgetWithText(ChipWidget, "Cocktails");
    expect(firstInterestWidgetFinder, findsOneWidget);

    final firstInterestWidgetStyle = tester.widget<ChipWidget>(firstInterestWidgetFinder);
    expect(firstInterestWidgetStyle.color, tertiaryColour);
    expect(firstInterestWidgetStyle.bordered, false);
    expect(firstInterestWidgetStyle.textColor, whiteColour);
    expect(firstInterestWidgetStyle.label, "Cocktails");

    final Finder secondInterestWidgetFinder = find.widgetWithText(ChipWidget, "Brunch");
    expect(secondInterestWidgetFinder, findsOneWidget);

    final secondInterestWidgetStyle = tester.widget<ChipWidget>(secondInterestWidgetFinder);
    expect(secondInterestWidgetStyle.color, tertiaryColour);
    expect(secondInterestWidgetStyle.bordered, false);
    expect(secondInterestWidgetStyle.textColor, whiteColour);
    expect(secondInterestWidgetStyle.label, "Brunch");

    final Finder thirdInterestWidgetFinder = find.widgetWithText(ChipWidget, "Coffee");
    expect(thirdInterestWidgetFinder, findsOneWidget);
  });

  testWidgets('second interest category View', (WidgetTester tester) async {
    CategorizedInterests selected = currentUser.userData.categorizedInterests!;

    await _widgetPumper.pumpWidget(tester, DisplayInterests(interests: selected));

    final Wrap wrapWidgetFinder = tester.widget<Wrap>(find.byType(Wrap));

    expect(wrapWidgetFinder.alignment, WrapAlignment.center);
    expect(wrapWidgetFinder.runAlignment, WrapAlignment.center);
    expect(wrapWidgetFinder.spacing, 6.0);
    expect(wrapWidgetFinder.runSpacing, 6.0);

    final Finder fourthInterestWidgetFinder = find.widgetWithText(ChipWidget, "Hiking");
    expect(fourthInterestWidgetFinder, findsOneWidget);

    final fourthInterestWidgetStyle = tester.widget<ChipWidget>(fourthInterestWidgetFinder);
    expect(fourthInterestWidgetStyle.color, tertiaryColour);
    expect(fourthInterestWidgetStyle.bordered, false);
    expect(fourthInterestWidgetStyle.textColor, whiteColour);
    expect(fourthInterestWidgetStyle.label, "Hiking");

    final Finder fifthInterestWidgetFinder = find.widgetWithText(ChipWidget, "Swimming");
    expect(fifthInterestWidgetFinder, findsOneWidget);

    final fifthInterestWidgetStyle = tester.widget<ChipWidget>(fifthInterestWidgetFinder);
    expect(fifthInterestWidgetStyle.color, tertiaryColour);
    expect(fifthInterestWidgetStyle.bordered, false);
    expect(fifthInterestWidgetStyle.textColor, whiteColour);
    expect(fifthInterestWidgetStyle.label, "Swimming");
  });
}
