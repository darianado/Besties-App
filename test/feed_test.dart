import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';

import 'helpers.dart';
import 'mock.dart';
import 'test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

/*
  group("Feed screen:", () {
    testWidgets("Contains correct information", (tester) async {
      await signInHelper(_widgetPumper, userEmail, "Password123");
      await _widgetPumper.pumpWidgetRouter(tester, "/feed");

      expect(find.byType(FeedScreen), findsOneWidget);

      final Finder refreshIndicatorFinder = find.byType(RefreshIndicator);
      expect(refreshIndicatorFinder, findsOneWidget);
      final RefreshIndicator refreshIndicator = tester.widget<RefreshIndicator>(refreshIndicatorFinder);
      expect(() => refreshIndicator.onRefresh(), returnsNormally);
    });
  });
  */

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
