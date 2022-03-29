import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'mock.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';
import 'package:project_seg/services/user_state.dart';

import 'test_resources/TestProfile.dart';
import 'test_resources/WidgetPumper.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  OtherUser firstProfile = TestProfile.firstProfile;

  group('Buttons widget tests', () {
    testWidgets('Test BioField Widget displays correct information',
        (tester) async {
      await WidgetPumper.pumpCustomWidget(
          tester, BioField(label: firstProfile.userData.bio!));

      expect(find.text(firstProfile.userData.bio!), findsOneWidget);
    });
  });
}
