import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
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

  UserData testUser = appUsersTestData[0]['data'] as UserData;

  group('RelationshipStatusButton Widget tests', () {
    testWidgets('Test RelationshipStatusButton displays correct information',
        (tester) async {
      await _widgetPumper.pumpWidget(tester,
          RelationshipStatusButton(label: testUser.relationshipStatus!));

      expect(find.text(testUser.relationshipStatus!), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.heart), findsOneWidget);

    });

    // testWidgets(
    //     'Test editable RelationshipStatusButton displays EditDialogDropdown Widget on tap',
    //     (tester) async {
    //   await _widgetPumper.pumpWidget(tester,
    //       RelationshipStatusButton(label: testUser.relationshipStatus!, editable: true));

    //   expect(find.text(testUser.relationshipStatus!), findsOneWidget);

    //   await tester.tap(find.text(testUser.relationshipStatus!));
    //   await tester.pump(const Duration(seconds: 1));

    //   expect(find.byType(EditDialogDropdown, skipOffstage: false), isOffstage);
    // });
  });
}