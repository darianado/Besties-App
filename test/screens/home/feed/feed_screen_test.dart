import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/screens/home/profile/edit_preferences_screen.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Feed screen:", () {
    testWidgets("Contains correct information", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/feed", null);

      expect(find.byType(FeedScreen), findsOneWidget);

      final Finder refreshIndicatorFinder = find.byType(RefreshIndicator);
      expect(refreshIndicatorFinder, findsOneWidget);

      final Finder pageViewFinder = find.byType(PageView);
      expect(pageViewFinder, findsOneWidget);
      final PageView pageView = tester.widget<PageView>(pageViewFinder);
      expect(pageView.physics, isNotNull);
      expect(pageView.physics, isA<CustomPageViewScrollPhysics>());

      expect(find.byType(ColorfulSafeArea), findsOneWidget);

      final Finder editPreferencesButtonFinder = find.byType(IconButton);
      expect(editPreferencesButtonFinder, findsOneWidget);
      final IconButton editPreferencesButton = tester.widget<IconButton>(editPreferencesButtonFinder);
      expect(find.descendant(of: editPreferencesButtonFinder, matching: find.byIcon(Icons.menu)), findsOneWidget);
      expect(editPreferencesButton.onPressed, isNotNull);
    });

    testWidgets("Page view scroll physics exists", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/feed", null);

      expect(find.byType(FeedScreen), findsOneWidget);

      final Finder refreshIndicatorFinder = find.byType(RefreshIndicator);
      expect(refreshIndicatorFinder, findsOneWidget);
      final RefreshIndicator refreshIndicator = tester.widget<RefreshIndicator>(refreshIndicatorFinder);
      expect(() => refreshIndicator.onRefresh(), returnsNormally);
      await tester.pump(const Duration(seconds: 1));
    });

    test("Page view scroll overrides spring", () async {
      const scrollViewPhysics = CustomPageViewScrollPhysics();
      expect(scrollViewPhysics.spring.mass, 80);
      expect(scrollViewPhysics.spring.stiffness, 50);
      expect(scrollViewPhysics.spring.damping, 0.7);
    });

    testWidgets("Refreshing feed", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/feed", null);

      expect(find.byType(FeedScreen), findsOneWidget);

      final Finder refreshIndicatorFinder = find.byType(RefreshIndicator);
      expect(refreshIndicatorFinder, findsOneWidget);
      final RefreshIndicator refreshIndicator = tester.widget<RefreshIndicator>(refreshIndicatorFinder);
      expect(() => refreshIndicator.onRefresh(), returnsNormally);
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets("Tapping edit preferences shows edit preferences screen", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/feed", null);

      expect(find.byType(FeedScreen), findsOneWidget);

      final Finder editPreferencesButtonFinder = find.byType(IconButton);
      expect(editPreferencesButtonFinder, findsOneWidget);
      final IconButton editPreferencesButton = tester.widget<IconButton>(editPreferencesButtonFinder);
      expect(editPreferencesButton.onPressed, isNotNull);

      expect(find.byType(EditPreferencesScreen), findsNothing);
      expect(() => editPreferencesButton.onPressed!(), returnsNormally);

      await tester.pumpAndSettle();

      expect(find.byType(EditPreferencesScreen), findsOneWidget);
    });
  });

  // UserData firstProfile = UserData(
  //   firstName: "Amy",
  //   lastName: "Garcia",
  //   university: "King's College London",
  // );

  // UserData secondProfile = UserData(
  //   firstName: "Jane",
  //   lastName: "Doe",
  //   university: "Imperial College London",
  // );

  // group('Feed Page widget tests', () {
  //   testWidgets('Test profile container displays profile information',
  //       (tester) async {
  //     await tester.pumpWidget(createFeedScreen());

  //     expect(find.text(firstProfile.firstName!), findsOneWidget);
  //     expect(find.text(firstProfile.university!), findsOneWidget);
  //   });

  //   testWidgets('Test swiping reveals new profile', (tester) async {
  //     await tester.pumpWidget(createFeedScreen());

  //     expect(find.text(firstProfile.firstName!), findsOneWidget);
  //     expect(find.text(firstProfile.university!), findsOneWidget);

  //     expect(find.text(secondProfile.firstName!), findsNothing);
  //     expect(find.text(secondProfile.university!), findsNothing);

  //     await tester.drag(
  //         find.text(firstProfile.firstName!), const Offset(0.0, -500.0));
  //     await tester.pumpAndSettle();

  //     expect(find.text(firstProfile.firstName!), findsNothing);
  //     expect(find.text(firstProfile.university!), findsOneWidget);

  //     expect(find.text(secondProfile.firstName!), findsOneWidget);
  //     expect(find.text(secondProfile.university!), findsOneWidget);
  //   });

  //   testWidgets('Test previous profiles are still reachable', (tester) async {
  //   await tester.pumpWidget(createFeedScreen());

  //   expect(find.text(firstProfile.firstName!), findsOneWidget);
  //   expect(find.text(firstProfile.university!), findsOneWidget);

  //   expect(find.text(secondProfile.firstName!), findsNothing);
  //   expect(find.text(secondProfile.university!), findsNothing);

  //   await tester.drag(
  //       find.text(firstProfile.firstName!), const Offset(0.0, -500.0));
  //   await tester.pumpAndSettle();

  //   expect(find.text(firstProfile.firstName!), findsNothing);
  //   expect(find.text(firstProfile.university!), findsOneWidget);

  //   expect(find.text(secondProfile.firstName!), findsOneWidget);
  //   expect(find.text(secondProfile.university!), findsOneWidget);

  //   await tester.drag(
  //       find.text(secondProfile.firstName!), const Offset(0.0, 500.0));
  //   await tester.pumpAndSettle();

  //   expect(find.text(firstProfile.firstName!), findsOneWidget);
  //   expect(find.text(firstProfile.university!), findsOneWidget);

  //   expect(find.text(secondProfile.firstName!), findsNothing);
  //   expect(find.text(secondProfile.university!), findsNothing);
  // });

  // testWidgets('Test tapping profile name shows bottom page', (tester) async {
  //   await tester.pumpWidget(createFeedPage());

  //   expect(find.text(firstProfile.firstName), findsOneWidget);
  //   expect(find.text(secondProfile.firstName), findsNothing);

  //   await tester.tap(find.text(firstProfile.firstName));
  //   expect(find.byKey(Key("Key")), findsOneWidget);
  // });
  // });
}
