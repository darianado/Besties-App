import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';
import 'package:project_seg/screens/home/profile/edit_preferences_screen.dart';

import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;
  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group('Edit preferences screen:', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/feed/edit-preferences", null);

      expect(find.byType(EditPreferencesScreen), findsOneWidget);

      final Finder rangeSliderFinder = find.byType(RangeSlider);
      expect(rangeSliderFinder, findsOneWidget);
      final RangeSlider rangeSlider = tester.widget<RangeSlider>(rangeSliderFinder);
      expect(rangeSlider.onChanged, isNotNull);

      final Finder genderRowFinder = find.byKey(const Key("genderRow"));
      expect(genderRowFinder, findsOneWidget);

      final Finder chipWidgetFinder = find.descendant(of: genderRowFinder, matching: find.byType(ChipWidget));
      expect(chipWidgetFinder, findsNWidgets(3));
      final ChipWidget firstChipWidget = tester.widget<ChipWidget>(chipWidgetFinder.first);
      expect(firstChipWidget.onTap, isNotNull);

      final Finder displayInterestsFinder = find.byType(DisplayInterests);
      expect(displayInterestsFinder, findsOneWidget);
      final DisplayInterests displayInterests = tester.widget<DisplayInterests>(displayInterestsFinder);
      expect(displayInterests.onSave, isNotNull);

      final Finder saveButtonFinder = find.byType(PillButtonFilled);
      expect(saveButtonFinder, findsOneWidget);
      final PillButtonFilled saveButton = tester.widget<PillButtonFilled>(saveButtonFinder);
      expect(saveButton.text, "Save information");

      final Finder cancelButtonFinder = find.byType(PillButtonOutlined);
      expect(cancelButtonFinder, findsOneWidget);
      final PillButtonOutlined cancelButton = tester.widget<PillButtonOutlined>(cancelButtonFinder);
      expect(cancelButton.text, "Cancel");
    });

    testWidgets('Changing range slider returns normally', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/feed/edit-preferences", null);

      expect(find.byType(EditPreferencesScreen), findsOneWidget);

      final Finder rangeSliderFinder = find.byType(RangeSlider);
      expect(rangeSliderFinder, findsOneWidget);
      final RangeSlider rangeSlider = tester.widget<RangeSlider>(rangeSliderFinder);
      expect(rangeSlider.onChanged, isNotNull);

      final min = rangeSlider.min;
      final max = rangeSlider.max;

      expect(() => rangeSlider.onChanged!(RangeValues(min, max)), returnsNormally);
      expect(() => rangeSlider.onChanged!(RangeValues(min + 2, max - 1)), returnsNormally);
    });

    testWidgets('Tapping gender button initially returns normally', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/feed/edit-preferences", null);

      expect(find.byType(EditPreferencesScreen), findsOneWidget);

      final Finder rangeSliderFinder = find.byType(RangeSlider);
      expect(rangeSliderFinder, findsOneWidget);
      final RangeSlider rangeSlider = tester.widget<RangeSlider>(rangeSliderFinder);
      expect(rangeSlider.onChanged, isNotNull);

      final Finder genderRowFinder = find.byKey(Key("genderRow"));
      expect(genderRowFinder, findsOneWidget);

      final Finder chipWidgetFinder = find.descendant(of: genderRowFinder, matching: find.byType(ChipWidget));
      expect(chipWidgetFinder, findsNWidgets(3));
      final ChipWidget firstChipWidget = tester.widget<ChipWidget>(chipWidgetFinder.at(0));
      expect(firstChipWidget.onTap, isNotNull);

      expect(() => firstChipWidget.onTap!(), returnsNormally);
    });

    testWidgets('Tapping gender button again returns normally', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/feed/edit-preferences", null);

      expect(find.byType(EditPreferencesScreen), findsOneWidget);

      final Finder rangeSliderFinder = find.byType(RangeSlider);
      expect(rangeSliderFinder, findsOneWidget);
      final RangeSlider rangeSlider = tester.widget<RangeSlider>(rangeSliderFinder);
      expect(rangeSlider.onChanged, isNotNull);

      final Finder genderRowFinder = find.byKey(Key("genderRow"));
      expect(genderRowFinder, findsOneWidget);

      final Finder chipWidgetFinder = find.descendant(of: genderRowFinder, matching: find.byType(ChipWidget));
      expect(chipWidgetFinder, findsNWidgets(3));
      final ChipWidget firstChipWidget = tester.widget<ChipWidget>(chipWidgetFinder.at(0));
      expect(firstChipWidget.onTap, isNotNull);
      expect(() => firstChipWidget.onTap!(), returnsNormally);

      final ChipWidget secondChipWidget = tester.widget<ChipWidget>(chipWidgetFinder.at(1));
      expect(secondChipWidget.onTap, isNotNull);
      expect(() => secondChipWidget.onTap!(), returnsNormally);
    });

    testWidgets('Saving interests returns normally', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/feed/edit-preferences", null);

      expect(find.byType(EditPreferencesScreen), findsOneWidget);

      final Finder displayInterestsFinder = find.byType(DisplayInterests);
      expect(displayInterestsFinder, findsOneWidget);
      final DisplayInterests displayInterests = tester.widget<DisplayInterests>(displayInterestsFinder);
      expect(displayInterests.onSave, isNotNull);

      expect(() => displayInterests.onSave!(testUser.categorizedInterests!), returnsNormally);
    });

    testWidgets('Tapping cancel returns normally', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/feed/edit-preferences", null);

      expect(find.byType(EditPreferencesScreen), findsOneWidget);

      final Finder cancelButtonFinder = find.byType(PillButtonOutlined);
      expect(cancelButtonFinder, findsOneWidget);
      final PillButtonOutlined cancelButton = tester.widget<PillButtonOutlined>(cancelButtonFinder);

      expect(() => cancelButton.onPressed(), returnsNormally);
    });

    testWidgets('Tapping save returns normally', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/feed/edit-preferences", null);

      expect(find.byType(EditPreferencesScreen), findsOneWidget);

      final Finder saveButtonFinder = find.byType(PillButtonFilled);
      expect(saveButtonFinder, findsOneWidget);
      final PillButtonFilled saveButton = tester.widget<PillButtonFilled>(saveButtonFinder);

      expect(() => saveButton.onPressed(), returnsNormally);
    });
  });
}
