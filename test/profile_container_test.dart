import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'mock.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';

import 'test_resources/TestProfile.dart';
import 'test_resources/WidgetPumper.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  OtherUser firstProfile = TestProfile.firstProfile;

  group('ProfileContainer widget tests', () {
    testWidgets('Test ProfileContainer Widget displays correct information',
        (tester) async {
      ValueKey key = const ValueKey("ProfileContainer Key");

      await WidgetPumper.pumpProfileContainer(tester, key, firstProfile);

      expect(find.text(firstProfile.userData.firstName!), findsOneWidget);
      expect(find.text(firstProfile.userData.university!), findsOneWidget);
      expect(find.byType(CachedImage), findsOneWidget);

      expect(find.text(firstProfile.userData.lastName!), findsNothing);
      expect(find.text(firstProfile.userData.age!.toString()), findsNothing);
      expect(
          find.text(firstProfile.userData.relationshipStatus!), findsNothing);
      expect(find.text(firstProfile.userData.bio!), findsNothing);

      expect(find.byType(GenderButton), findsNothing);
    });

    testWidgets(
        'Test SlidingProfileDetails Widget displays correct information',
        (tester) async {
      ValueKey key = const ValueKey("SlidingProfileDetails Key");
      await WidgetPumper.pumpSlidingProfileDetails(tester, key, firstProfile);

      expect(find.text(firstProfile.userData.fullName!), findsOneWidget);
      expect(find.text(firstProfile.userData.university!), findsOneWidget);
      expect(find.text(firstProfile.userData.age!.toString()), findsOneWidget);
      expect(
          find.text(firstProfile.userData.relationshipStatus!), findsOneWidget);
      expect(find.text(firstProfile.userData.bio!), findsOneWidget);

      expect(find.byType(GenderButton), findsOneWidget);
    });
  });
}
