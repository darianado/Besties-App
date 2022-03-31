import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/home/chat/chat_screen.dart';
import 'package:project_seg/screens/home/chat/components/matches_scroll_view.dart';
import 'package:project_seg/screens/home/chat/components/recent_chats_scroll_view.dart';
import 'package:project_seg/screens/home/chat/widgets/contact_list.dart';
import 'package:project_seg/screens/home/chat/widgets/recent_chats.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Chat screen:", () {
    testWidgets("Contains correct information", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat", null);

      await tester.pump(Duration(seconds: 2));

      expect(find.byType(ChatScreen), findsOneWidget);

      final Finder pageContainerFinder = find.ancestor(of: find.byType(Matches), matching: find.byType(Container)).first;
      expect(pageContainerFinder, findsOneWidget);
      final Container pageContainer = tester.widget<Container>(pageContainerFinder);
      expect(pageContainer.decoration, isNotNull);
      expect(pageContainer.decoration, isA<BoxDecoration>());
      final BoxDecoration boxDecoration = pageContainer.decoration as BoxDecoration;
      expect(boxDecoration.gradient, isNotNull);
      expect(boxDecoration.gradient!.stops, containsAll([0.4, 0.8, 1]));
      expect(boxDecoration.gradient!.colors, containsAll([whiteColour, whiteColourShade2, whiteColourShade3]));

      expect(find.textContaining("New matches"), findsOneWidget);
      expect(find.textContaining("Chats"), findsOneWidget);

      final Finder matchesFinder = find.byType(Matches);
      expect(matchesFinder, findsOneWidget);

      final Finder chatsFinder = find.byType(RecentChats);
      expect(chatsFinder, findsOneWidget);

      expect(find.textContaining("You haven't started any chats yet"), findsNothing);
      expect(find.textContaining("No new matches"), findsNothing);

      final Finder matchesScrollViewFinder = find.byType(MatchesScrollView);
      expect(matchesScrollViewFinder, findsOneWidget);
      final MatchesScrollView matchesScrollView = tester.widget<MatchesScrollView>(matchesScrollViewFinder);
      expect(matchesScrollView.matches, isNotEmpty);

      final Finder chatsScrollViewFinder = find.byType(RecentChatsScrollView);
      expect(chatsScrollViewFinder, findsOneWidget);
      final RecentChatsScrollView chatsScrollView = tester.widget<RecentChatsScrollView>(chatsScrollViewFinder);
      expect(chatsScrollView.chats, isNotEmpty);
    });
  });
}
