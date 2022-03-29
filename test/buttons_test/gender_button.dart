import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/models/User/other_user.dart';
import '../mock.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';

import '../test_resources/test_profile.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
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

  OtherUser firstProfile = TestProfile.firstProfile;

  group('GenderButton Widget tests', () {
    testWidgets('Test GenderButton displays correct information',
        (tester) async {
      await WidgetPumper.pumpCustomWidget(
          tester, GenderButton(label: firstProfile.userData.gender!));

      expect(
          find.byIcon(
              getIconForGender(firstProfile.userData.gender!.toLowerCase())),
          findsOneWidget);
    });
  });
}