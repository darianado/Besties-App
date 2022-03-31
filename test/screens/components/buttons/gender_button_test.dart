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

import '../../../test_resources/test_profile.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  IconData getIconForGender(String? gender) {
    switch (gender?.toLowerCase()) {
      case "male":
        return FontAwesomeIcons.mars;
      case "female":
        return FontAwesomeIcons.venus;
      default:
        return FontAwesomeIcons.venusMars;
    }
  }

  UserData testUser = appUsersTestData[0]['data'] as UserData;

  group('GenderButton Widget tests', () {
    testWidgets('Test GenderButton displays correct information',
        (tester) async {
      await _widgetPumper.pumpWidget(
          tester, GenderButton(label: testUser.gender!));

      expect(find.byIcon(getIconForGender(testUser.gender!.toLowerCase())),
          findsOneWidget);
    });

    // testWidgets(
    //     'Test editable GenderButton displays EditDialogDropdown Widget on tap',
    //     (tester) async {
    //   await _widgetPumper.pumpWidget(tester,
    //       GenderButton(label: testUser.gender!, editable: true));

    //   expect(find.byIcon(getIconForGender(testUser.gender!.toLowerCase())), findsOneWidget);

    //   await tester.tap(find.byIcon(getIconForGender(testUser.gender!.toLowerCase())));
    //   await tester.pump(const Duration(seconds: 1));

    //   expect(find.byType(EditDialogDropdown, skipOffstage: false), isOffstage);
    // });
  });
}
