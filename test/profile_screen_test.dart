import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/OtherUser.dart';
import 'package:project_seg/dalu_auth/mock.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/components/widget/display_interests.dart';
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

  group('ProfileScreen widget tests', () {
    testWidgets('Test ProfileInformation Widget displays correct information',
        (tester) async {
      ValueKey key = const ValueKey("ProfileScreen Key");

      await WidgetPumper.pumpProfileScreen(tester, key, firstProfile.userData);

      expect(find.text(firstProfile.userData.fullName!), findsOneWidget);
      expect(find.text(firstProfile.userData.university!), findsOneWidget);
      expect(find.text(firstProfile.userData.age!.toString()), findsOneWidget);

      expect(
          find.text(firstProfile.userData.relationshipStatus!), findsOneWidget);
      expect(find.text(firstProfile.userData.bio!), findsOneWidget);
      
      expect(find.byType(DisplayInterests), findsOneWidget);
      expect(find.byType(GenderButtton), findsOneWidget);
    });
  });
}
