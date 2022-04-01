import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_interests.dart';
import 'package:project_seg/screens/components/interests/category_view.dart';
import 'package:project_seg/screens/components/interests/edit_interests_bottom_sheet.dart';
import 'package:project_seg/screens/components/interests/select_interests.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';
import '../../../test_resources/test_profile.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group("Select interests widget:", () {
    testWidgets('Contains required information', (WidgetTester tester) async {
      CategorizedInterests selected = testUser.categorizedInterests!;

      await _widgetPumper.pumpWidget(
          tester,
          SelectInterests(
            selected: selected,
            onChange: (_) {},
          ));

      await tester.pump(Duration(seconds: 2));

      final Finder categoriesFinder = find.byType(CategoryView);
      expect(categoriesFinder, findsNWidgets(3));
    });

    testWidgets('Tap on category shows bottom sheet', (WidgetTester tester) async {
      CategorizedInterests selected = testUser.categorizedInterests!;

      await _widgetPumper.pumpWidget(
          tester,
          SelectInterests(
            selected: selected,
            onChange: (_) {},
          ));

      await tester.pump(Duration(seconds: 2));

      final Finder categoriesFinder = find.byType(CategoryView);
      expect(categoriesFinder, findsNWidgets(3));

      expect(find.byType(EditInterestBottomSheet), findsNothing);

      await tester.tap(categoriesFinder.first);
      await tester.pump();

      expect(find.byType(EditInterestBottomSheet), findsOneWidget);
    });

    testWidgets('onChange of bottom sheet returns normally', (WidgetTester tester) async {
      CategorizedInterests selected = testUser.categorizedInterests!;

      await _widgetPumper.pumpWidget(
          tester,
          SelectInterests(
            selected: selected,
            onChange: (_) {},
          ));

      await tester.pump(Duration(seconds: 2));

      final Finder categoriesFinder = find.byType(CategoryView);
      expect(categoriesFinder, findsNWidgets(3));

      expect(find.byType(EditInterestBottomSheet), findsNothing);

      await tester.tap(categoriesFinder.first);
      await tester.pump();

      final Finder bottomSheetFinder = find.byType(EditInterestBottomSheet);
      expect(bottomSheetFinder, findsOneWidget);
      final EditInterestBottomSheet bottomSheet = tester.widget<EditInterestBottomSheet>(bottomSheetFinder);

      expect(() => bottomSheet.onChange(bottomSheet.category), returnsNormally);
    });
  });
}
