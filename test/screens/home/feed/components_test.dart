import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';
import 'package:project_seg/screens/components/sliding_profile_details.dart';
import 'package:project_seg/screens/home/feed/components/like_profile_button.dart';
import 'package:project_seg/screens/home/feed/components/profile_container.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;
  UserData otherUser = appUsersTestData[1]['data'] as UserData;

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group('Profile container:', () {
    testWidgets('Contains correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, ProfileContainer(profile: testUser, liked: false, onLikeComplete: () => {}));

      expect(find.text(testUser.firstName!), findsOneWidget);
      expect(find.text(testUser.university!), findsOneWidget);
      expect(find.byType(CachedImage), findsOneWidget);

      expect(find.text(testUser.lastName!), findsNothing);
      expect(find.text(testUser.age!.toString()), findsNothing);
      expect(find.text(testUser.relationshipStatus!), findsNothing);
      expect(find.text(testUser.bio!), findsNothing);

      final Finder gestureDetectorFinder = find.ancestor(of: find.byType(Row), matching: find.byType(GestureDetector)).first;
      expect(gestureDetectorFinder, findsOneWidget);
      final GestureDetector gestureDetector = tester.widget<GestureDetector>(gestureDetectorFinder);
      expect(gestureDetector.onTap, isNotNull);

      expect(find.byType(SlidingProfileDetails), findsNothing);
      expect(() => gestureDetector.onTap!(), returnsNormally);
      await tester.pump();
      expect(find.byType(SlidingProfileDetails), findsOneWidget);
    });
  });

  group("Sliding profile details", () {
    testWidgets('Contains correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, SlidingProfileDetails(profile: testUser));

      expect(find.text(testUser.fullName!), findsOneWidget);
      expect(find.text(testUser.university!), findsOneWidget);
      expect(find.text(testUser.age!.toString()), findsOneWidget);
      expect(find.text(testUser.relationshipStatus!), findsOneWidget);
      expect(find.text(testUser.bio!), findsOneWidget);

      expect(find.byType(GenderButton), findsOneWidget);
    });
  });

  group("Like profile button", () {
    testWidgets('Contains correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, LikeProfileButton(profile: testUser, liked: false, onLikeComplete: () {}));

      expect(find.byType(Lottie), findsOneWidget);

      final Finder roundActionButtonFinder = find.byType(RoundActionButton);
      expect(roundActionButtonFinder, findsOneWidget);
      final RoundActionButton roundActionButton = tester.widget<RoundActionButton>(roundActionButtonFinder);
      expect(roundActionButton.onPressed, isNotNull);
    });

    testWidgets('Tapping like returns normally', (tester) async {
      await signOutHelper(_widgetPumper);
      await signInHelper(_widgetPumper, "johndoe@example.org");
      await _widgetPumper.pumpWidget(tester, LikeProfileButton(profile: otherUser, liked: false, onLikeComplete: () {}));

      expect(find.byType(Lottie), findsOneWidget);

      final Finder roundActionButtonFinder = find.byType(RoundActionButton);
      expect(roundActionButtonFinder, findsOneWidget);
      final RoundActionButton roundActionButton = tester.widget<RoundActionButton>(roundActionButtonFinder);
      expect(roundActionButton.onPressed, isNotNull);
      expect(() => roundActionButton.onPressed!(), returnsNormally);
      await tester.pumpAndSettle();
    });
  });
}
