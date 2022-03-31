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

  group('EditDialogDropdown Widget tests', () {
    // testWidgets('Test EditDialogDropdown Widget saves new fields once edited',
    //     (tester) async {
    //   String newGender = "Female";
    //   String oldGender = testUser.gender!;

    //   await _widgetPumper.pumpWidget(
    //     tester,
    //     EditDialogDropdown(
    //       items: appContextTestData['genders'] as List<String>,
    //       value: testUser.gender!,
    //       onSave: (gender) {
    //         testUser.gender = gender;
    //       },
    //     ),
    //   );

    //   expect(find.text(oldGender), findsOneWidget);

    //   await tester.tap(find.text(oldGender));
    //   await tester.pump(const Duration(seconds: 1));

    //   expect(find.byType(EditDialog), findsOneWidget);
    //   await tester.tap(find.byType(EditDialog));
    //   await tester.pump(const Duration(seconds: 1));

    //   await tester.tap(find.text("Save"));
    //   await tester.pump(const Duration(seconds: 1));

    //   expect(find.text(newGender), findsOneWidget);
    //   expect(find.text(oldGender), findsNothing);
    // });
  });
}
