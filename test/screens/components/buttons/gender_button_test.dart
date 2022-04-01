import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_dropdown.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/utility/helpers.dart';

import '../../../test_resources/test_profile.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  UserData testUser = appUsersTestData[0]['data'] as UserData;

  group('Gender button widget:', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, GenderButton(label: testUser.gender!));

      expect(find.byIcon(getIconForGender(testUser.gender!.toLowerCase())), findsOneWidget);
    });

    testWidgets('Tapping opens dialog', (tester) async {
      await _widgetPumper.pumpWidget(
          tester,
          GenderButton(
            label: testUser.gender!,
            editable: true,
            onSave: (gender) => _widgetPumper.firebaseEnv.firestoreService.setGender(testUser.uid!, gender!),
          ));

      final Finder chipFinder = find.byType(ChipWidget);
      expect(chipFinder, findsOneWidget);
      final ChipWidget chipWidget = tester.widget<ChipWidget>(chipFinder);

      expect(find.byType(EditDialogDropdown), findsNothing);
      expect(() => chipWidget.onTap!(), returnsNormally);
      await tester.pump(Duration(seconds: 1));
      expect(find.byType(EditDialogDropdown), findsOneWidget);
    });
  });
}
