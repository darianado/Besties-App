import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/sign_up/register_interests_screen.dart';
import 'package:project_seg/constants/colours.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();
  UserData currentUserData = UserData();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  testWidgets('interests page has all widgets', (WidgetTester tester) async {
    await _widgetPumper.pumpWidget(tester, RegisterInterestsScreen(userData: currentUserData));

    final Finder iconButton = find.byType(Icon);
    expect(iconButton, findsOneWidget);
    final iconStyle = tester.widget<Icon>(iconButton);
    expect(iconStyle.color, primaryColour);

    final Finder textHeaderFinder = find.text('Finally, what do you like?');
    expect(textHeaderFinder, findsOneWidget);
    final textHeaderStyle = tester.widget<Text>(textHeaderFinder);
    expect(textHeaderStyle.style?.color, secondaryColour);

    final Finder textFinder = find.text("It is time to let us know more about your interests.");
    expect(textFinder, findsOneWidget);
    final textStyle = tester.widget<Text>(textFinder);
    expect(textStyle.textAlign, TextAlign.center);

    final Finder textParagraphFinder = find.byType(SliverFillRemaining);
    expect(textParagraphFinder, findsOneWidget);

    final Finder nextTextFinder = find.text('Done');
    expect(nextTextFinder, findsOneWidget);

    final Finder buttonFinder = find.widgetWithText(PillButtonFilled, 'Done');
    expect(buttonFinder, findsOneWidget);

    final buttonStyle = tester.widget<PillButtonFilled>(buttonFinder);
    expect(buttonStyle.text, 'Done');
    expect(buttonStyle.textStyle!.fontSize, 25);
    expect(buttonStyle.backgroundColor, tertiaryColour);
    expect(buttonStyle.textStyle!.fontWeight, FontWeight.w600);
  });
}
