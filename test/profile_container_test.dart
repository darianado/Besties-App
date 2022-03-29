import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/sliding_profile_details.dart';
import 'package:project_seg/screens/home/feed/components/profile_container.dart';
import 'mock.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';

import 'test_resources/test_profile.dart';
import 'test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup();
  });

  OtherUser firstProfile = TestProfile.firstProfile;

  group('ProfileContainer widget tests', () {
    testWidgets('Test ProfileContainer Widget displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, ProfileContainer(profile: firstProfile, onLikeComplete: () => {}));

      expect(find.text(firstProfile.userData.firstName!), findsOneWidget);
      expect(find.text(firstProfile.userData.university!), findsOneWidget);
      expect(find.byType(CachedImage), findsOneWidget);

      expect(find.text(firstProfile.userData.lastName!), findsNothing);
      expect(find.text(firstProfile.userData.age!.toString()), findsNothing);
      expect(find.text(firstProfile.userData.relationshipStatus!), findsNothing);
      expect(find.text(firstProfile.userData.bio!), findsNothing);

      expect(find.byType(GenderButton), findsNothing);
    });

    testWidgets('Test SlidingProfileDetails Widget displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, SlidingProfileDetails(profile: firstProfile.userData));

      expect(find.text(firstProfile.userData.fullName!), findsOneWidget);
      expect(find.text(firstProfile.userData.university!), findsOneWidget);
      expect(find.text(firstProfile.userData.age!.toString()), findsOneWidget);
      expect(find.text(firstProfile.userData.relationshipStatus!), findsOneWidget);
      expect(find.text(firstProfile.userData.bio!), findsOneWidget);

      expect(find.byType(GenderButton), findsOneWidget);
    });
  });
}
