import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import '../mock.dart';

import '../test_resources/test_profile.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  OtherUser firstProfile = TestProfile.firstProfile;

  group('DateOfBirthButton Widget tests', () {
    testWidgets('Test DateOfBirthButton displays correct information',
        (tester) async {
      await WidgetPumper.pumpCustomWidget(tester,
          DateOfBirthButton(label: firstProfile.userData.age!.toString()));

      expect(find.text(firstProfile.userData.age!.toString()), findsOneWidget);
    });
  });
}