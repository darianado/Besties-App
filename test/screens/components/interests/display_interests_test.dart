import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_interests.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';

import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group("Display interests widget:", () {
    testWidgets('Contains required information', (WidgetTester tester) async {
      CategorizedInterests selected = testUser.categorizedInterests!;

      await _widgetPumper.pumpWidget(tester, DisplayInterests(interests: selected));

      final Wrap wrapWidgetFinder = tester.widget<Wrap>(find.byType(Wrap));

      expect(wrapWidgetFinder.alignment, WrapAlignment.center);
      expect(wrapWidgetFinder.runAlignment, WrapAlignment.center);
      expect(wrapWidgetFinder.spacing, 6.0);
      expect(wrapWidgetFinder.runSpacing, 6.0);

      final Finder cocktailsWidgetFinder = find.widgetWithText(ChipWidget, "Cocktails");
      expect(cocktailsWidgetFinder, findsOneWidget);

      final cocktailsWidget = tester.widget<ChipWidget>(cocktailsWidgetFinder);
      expect(cocktailsWidget.color, tertiaryColour);
      expect(cocktailsWidget.bordered, false);
      expect(cocktailsWidget.capitalizeLabel, true);
      expect(cocktailsWidget.textColor, whiteColour);
      expect(cocktailsWidget.label, "Cocktails");

      final Finder brunchWidgetFinder = find.widgetWithText(ChipWidget, "Brunch");
      expect(brunchWidgetFinder, findsOneWidget);

      final brunchWidget = tester.widget<ChipWidget>(brunchWidgetFinder);
      expect(brunchWidget.color, tertiaryColour);
      expect(brunchWidget.bordered, false);
      expect(brunchWidget.capitalizeLabel, true);
      expect(brunchWidget.textColor, whiteColour);
      expect(brunchWidget.label, "Brunch");

      final Finder comedyWidgetFinder = find.widgetWithText(ChipWidget, "Stand-up comedy");
      expect(comedyWidgetFinder, findsOneWidget);

      final comedyWidget = tester.widget<ChipWidget>(comedyWidgetFinder);
      expect(comedyWidget.color, tertiaryColour);
      expect(comedyWidget.bordered, false);
      expect(comedyWidget.capitalizeLabel, true);
      expect(comedyWidget.textColor, whiteColour);
      expect(comedyWidget.label, "Stand-up comedy");

      final Finder medicineWidgetFinder = find.widgetWithText(ChipWidget, "Medicine");
      expect(medicineWidgetFinder, findsOneWidget);

      final medicineWidget = tester.widget<ChipWidget>(medicineWidgetFinder);
      expect(medicineWidget.color, tertiaryColour);
      expect(medicineWidget.bordered, false);
      expect(medicineWidget.capitalizeLabel, true);
      expect(medicineWidget.textColor, whiteColour);
      expect(medicineWidget.label, "Medicine");
    });

    testWidgets('Tapping opens dialog', (tester) async {
      await _widgetPumper.pumpWidget(
          tester,
          DisplayInterests(
            interests: testUser.categorizedInterests!,
            editable: true,
            onSave: (categorizedInterests) => _widgetPumper.firebaseEnv.firestoreService.setInterests(testUser.uid!, categorizedInterests),
          ));

      final Finder chipFinder = find.byType(ChipWidget);
      expect(chipFinder, findsWidgets);
      final ChipWidget chipWidget = tester.widget<ChipWidget>(chipFinder.first);

      expect(find.byType(EditDialogInterests), findsNothing);
      expect(() => chipWidget.onTap!(), returnsNormally);
      await tester.pump(Duration(seconds: 1));
      expect(find.byType(EditDialogInterests), findsOneWidget);
    });
  });
}
