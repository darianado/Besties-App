import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_interests.dart';
import 'package:project_seg/screens/components/interests/select_interests.dart';

import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group('Edit dialog interests widget:', () {
    testWidgets('onChange returns normally', (tester) async {
      await _widgetPumper.pumpWidget(
        tester,
        EditDialogInterests(
          interests: testUser.categorizedInterests!,
          onSave: (categorizedInterests) {
            testUser.categorizedInterests = categorizedInterests;
          },
        ),
      );

      final Finder selectInterestsFinder = find.byType(SelectInterests);
      expect(selectInterestsFinder, findsOneWidget);
      final SelectInterests selectInterests = tester.widget<SelectInterests>(selectInterestsFinder);

      expect(() => selectInterests.onChange(testUser.categorizedInterests!), returnsNormally);
    });

    testWidgets('onSave with too few selected returns normally', (tester) async {
      await _widgetPumper.pumpWidget(
        tester,
        EditDialogInterests(
          interests: CategorizedInterests(categories: []),
          onSave: (categorizedInterests) {
            testUser.categorizedInterests = categorizedInterests;
          },
        ),
      );

      final Finder editDialogFinder = find.byType(EditDialog);
      expect(editDialogFinder, findsOneWidget);
      final EditDialog editDialog = tester.widget<EditDialog>(editDialogFinder);

      expect(() => editDialog.onSave(), returnsNormally);
    });

    testWidgets('onSave with valid selection returns normally', (tester) async {
      await _widgetPumper.pumpWidget(
        tester,
        EditDialogInterests(
          interests: testUser.categorizedInterests!,
          onSave: (categorizedInterests) {
            testUser.categorizedInterests = categorizedInterests;
          },
        ),
      );

      final Finder editDialogFinder = find.byType(EditDialog);
      expect(editDialogFinder, findsOneWidget);
      final EditDialog editDialog = tester.widget<EditDialog>(editDialogFinder);

      expect(() => editDialog.onSave(), returnsNormally);
    });

    testWidgets('onSave with too many selected returns normally', (tester) async {
      await _widgetPumper.pumpWidget(
        tester,
        EditDialogInterests(
          interests: CategorizedInterests(categories: [
            Category(title: "Test", interests: [
              Interest(title: "Sample1"),
              Interest(title: "Sample2"),
              Interest(title: "Sample3"),
              Interest(title: "Sample4"),
              Interest(title: "Sample5"),
              Interest(title: "Sample6"),
              Interest(title: "Sample7"),
              Interest(title: "Sample8"),
              Interest(title: "Sample9"),
              Interest(title: "Sample10"),
              Interest(title: "Sample11"),
            ])
          ]),
          onSave: (categorizedInterests) {
            testUser.categorizedInterests = categorizedInterests;
          },
        ),
      );

      final Finder editDialogFinder = find.byType(EditDialog);
      expect(editDialogFinder, findsOneWidget);
      final EditDialog editDialog = tester.widget<EditDialog>(editDialogFinder);

      expect(() => editDialog.onSave(), returnsNormally);
    });
  });
}
