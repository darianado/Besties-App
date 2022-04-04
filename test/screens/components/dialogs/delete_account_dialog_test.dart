import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/dialogs/delete_account_dialog.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/utility/form_validators.dart';

import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group('Delete account dialog:', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, DeleteAccountDialog());

      final Finder cancelButtonFinder = find.widgetWithText(PillButtonOutlined, "Cancel");
      expect(cancelButtonFinder, findsOneWidget);

      expect(find.byType(EditDialog), findsOneWidget);

      final Finder passwordTextFieldFinder = find.widgetWithText(TextFormField, "Password");
      expect(passwordTextFieldFinder, findsOneWidget);
      final TextFormField passwordTextFormField = tester.widget<TextFormField>(passwordTextFieldFinder);
      expect(passwordTextFormField.controller, isNotNull);
      expect(passwordTextFormField.validator, validatePassword);
    });

    testWidgets('Executing onSave with no information returns normally', (tester) async {
      await _widgetPumper.pumpWidget(tester, DeleteAccountDialog());

      final Finder editDialogFinder = find.byType(EditDialog);
      expect(editDialogFinder, findsOneWidget);
      final EditDialog editDialog = tester.widget<EditDialog>(editDialogFinder);
      expect(() => editDialog.onSave(), returnsNormally);
    });

    testWidgets('Executing onSave with valid information returns normally', (tester) async {
      await _widgetPumper.pumpWidget(tester, DeleteAccountDialog());

      final Finder passwordTextFieldFinder = find.widgetWithText(TextFormField, "Password");
      expect(passwordTextFieldFinder, findsOneWidget);

      await tester.enterText(passwordTextFieldFinder, "Password123");
      await tester.pump();

      final Finder editDialogFinder = find.byType(EditDialog);
      expect(editDialogFinder, findsOneWidget);
      final EditDialog editDialog = tester.widget<EditDialog>(editDialogFinder);
      expect(() => editDialog.onSave(), returnsNormally);
    });
  });
}
