import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'mock.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';

import 'test_resources/test_profile.dart';
import 'test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup();
  });

  OtherUser firstProfile = TestProfile.firstProfile;

  group('ProfileScreen widget tests', () {
    testWidgets('Test ProfileInformation Widget displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, ProfileInformation(userData: firstProfile.userData, editable: false));

      expect(find.text(firstProfile.userData.fullName!), findsOneWidget);
      expect(find.text(firstProfile.userData.university!), findsOneWidget);
      expect(find.text(firstProfile.userData.age!.toString()), findsOneWidget);

      expect(find.text(firstProfile.userData.relationshipStatus!), findsOneWidget);
      expect(find.text(firstProfile.userData.bio!), findsOneWidget);

      expect(find.byType(DisplayInterests), findsOneWidget);
      expect(find.byType(GenderButton), findsOneWidget);
    });
  });
}
