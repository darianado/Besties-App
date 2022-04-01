import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_dropdown.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_textfield.dart';

import '../../../test_resources/test_profile.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;
  final possibleGenders = appContextTestData['genders'] as List<String>;

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group('Edit dialog dropdown widget:', () {
    testWidgets('onChanged returns normally', (tester) async {
      await _widgetPumper.pumpWidget(
        tester,
        EditDialogDropdown(
          items: possibleGenders,
          value: possibleGenders[0],
          onSave: (gender) {
            testUser.gender = gender;
          },
        ),
      );

      final Finder dropdownFinder = find.byType(DropdownButton<String>);
      expect(dropdownFinder, findsOneWidget);
      final DropdownButton<String> dropdownButton = tester.widget<DropdownButton<String>>(dropdownFinder);
      expect(dropdownButton.onChanged, isNotNull);

      expect(() => dropdownButton.onChanged!(possibleGenders[1]), returnsNormally);
    });

    testWidgets('onSave returns normally', (tester) async {
      await _widgetPumper.pumpWidget(
        tester,
        EditDialogDropdown(
          items: possibleGenders,
          value: possibleGenders[0],
          onSave: (gender) {
            testUser.gender = gender;
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
