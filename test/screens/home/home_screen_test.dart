import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/binding.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/home/chat/chat_screen.dart';
import 'package:project_seg/screens/home/components/nav_bar.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/screens/home/home_screen.dart';
import 'package:project_seg/screens/home/profile/profile_screen.dart';

import '../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";
  const String profilePath = "/profile";
  const String feedPath = "/feed";
  const String chatPath = "/chat";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Home screen:", () {
    testWidgets("Contains correct information", (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, feedPath, null);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.byType(FeedScreen), findsOneWidget);
      expect(find.byType(ChatScreen), findsOneWidget);
      expect(find.byType(NavBar), findsOneWidget);
    });

    testWidgets("Nav bar contains correct information", (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, feedPath, null);

      final Finder navBarFinder = find.byType(NavBar);
      expect(navBarFinder, findsOneWidget);

      final NavBar navBar = tester.widget<NavBar>(navBarFinder);
      expect(navBar.menuData.items, hasLength(3));

      expect(navBar.menuData.entries[0].icon, FontAwesomeIcons.solidUserCircle);
      expect(navBar.menuData.entries[1].icon, FontAwesomeIcons.home);
      expect(navBar.menuData.entries[2].icon, FontAwesomeIcons.solidComment);
    });

    testWidgets("Tapping left-most item shows profile screen", (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, feedPath, null);

      final Finder navBarFinder = find.byType(NavBar);
      expect(navBarFinder, findsOneWidget);
      final NavBar navBar = tester.widget<NavBar>(navBarFinder);

      final IndexedStack indexedStackBefore = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStackBefore.index, 1);
      expect(() => navBar.onPressed(0), returnsNormally);
      await tester.pump();
      final IndexedStack indexedStackAfter = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStackAfter.index, 0);
    });

    testWidgets("Tapping left-most item shows feed screen", (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, profilePath, null);

      final Finder navBarFinder = find.byType(NavBar);
      expect(navBarFinder, findsOneWidget);
      final NavBar navBar = tester.widget<NavBar>(navBarFinder);

      final IndexedStack indexedStackBefore = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStackBefore.index, 0);
      expect(() => navBar.onPressed(1), returnsNormally);
      await tester.pump();
      final IndexedStack indexedStackAfter = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStackAfter.index, 1);
    });

    testWidgets("Tapping left-most item shows chat screen", (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, feedPath, null);

      final Finder navBarFinder = find.byType(NavBar);
      expect(navBarFinder, findsOneWidget);
      final NavBar navBar = tester.widget<NavBar>(navBarFinder);

      final IndexedStack indexedStackBefore = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStackBefore.index, 1);
      expect(() => navBar.onPressed(2), returnsNormally);
      await tester.pump();
      final IndexedStack indexedStackAfter = tester.widget<IndexedStack>(find.byType(IndexedStack));
      expect(indexedStackAfter.index, 2);
    });
  });
}
