import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import '../../../test_resources/firebase_mocks.dart';

import '../../../test_resources/test_profile.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  UserData testUser = appUsersTestData[0]['data'] as UserData;

  group('DateOfBirthButton Widget tests', () {
    testWidgets('Test DateOfBirthButton displays correct information',
        (tester) async {
      await _widgetPumper.pumpWidget(
          tester, DateOfBirthButton(label: testUser.age!.toString()));

      expect(find.text(testUser.age!.toString()), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.birthdayCake), findsOneWidget);
    });
  });
}
