import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/feed.dart';
import 'package:project_seg/mock.dart';
import 'package:project_seg/profile_class.dart';

Widget createFeedPage() => const MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: Feed(
          //key: Key("Key"),
        ),
      ),
    );

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  Profile firstProfile = Profile(seed: 0);
  Profile secondProfile = Profile(seed: 1);
  group('Feed Page widget tests', () {
    testWidgets('Test profile container displays profile information',
        (tester) async {
      await tester.pumpWidget(createFeedPage());

      expect(find.text(firstProfile.firstName), findsOneWidget);
      //expect(find.text(firstProfile.lastName), findsOneWidget);
      expect(find.text(firstProfile.continent), findsOneWidget);
    });

    testWidgets('Test swiping reveals new profile', (tester) async {
      await tester.pumpWidget(createFeedPage());

      expect(find.text(firstProfile.firstName), findsOneWidget);
      expect(find.text(secondProfile.firstName), findsNothing);

      await tester.drag(
          find.text(firstProfile.firstName), const Offset(0.0, -500.0));
      await tester.pumpAndSettle();

      expect(find.text(firstProfile.firstName), findsNothing);
      expect(find.text(secondProfile.firstName), findsOneWidget);
    });

    testWidgets('Test previous profiles are still reachable', (tester) async {
      await tester.pumpWidget(createFeedPage());

      expect(find.text(firstProfile.firstName), findsOneWidget);
      expect(find.text(secondProfile.firstName), findsNothing);

      await tester.drag(
          find.text(firstProfile.firstName), const Offset(0.0, -500.0));
      await tester.pumpAndSettle();

      expect(find.text(firstProfile.firstName), findsNothing);
      expect(find.text(secondProfile.firstName), findsOneWidget);

      await tester.drag(
          find.text(secondProfile.firstName), const Offset(0.0, 500.0));
      await tester.pumpAndSettle();

      expect(find.text(firstProfile.firstName), findsOneWidget);
      expect(find.text(secondProfile.firstName), findsNothing);
    });

    // testWidgets('Test tapping profile name shows bottom page', (tester) async {
    //   await tester.pumpWidget(createFeedPage());

    //   expect(find.text(firstProfile.firstName), findsOneWidget);
    //   expect(find.text(secondProfile.firstName), findsNothing);

    //   await tester.tap(find.text(firstProfile.firstName));
    //   expect(find.byKey(Key("Key")), findsOneWidget);
    // });
  });
}
