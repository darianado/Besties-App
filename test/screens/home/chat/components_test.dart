import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/screens/home/chat/chat_screen.dart';
import 'package:project_seg/screens/home/chat/chat_thread_screen.dart';
import 'package:project_seg/screens/home/chat/components/matches_scroll_view.dart';
import 'package:project_seg/screens/home/chat/components/message_composer.dart';
import 'package:project_seg/screens/home/chat/components/profile_app_bar_button.dart';
import 'package:project_seg/screens/home/chat/components/recent_chats_scroll_view.dart';
import 'package:project_seg/screens/home/chat/widgets/contact_list.dart';
import 'package:project_seg/screens/home/chat/widgets/recent_chats.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  final UserMatch testMatch = (appUserMatchesTestData[0]['match'] as UserMatch);
  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("MatchesScrollView:", () {
    testWidgets("Contains correct information", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat", null);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(ChatScreen), findsOneWidget);

      final Finder matchesFinder = find.byType(Matches);
      expect(matchesFinder, findsOneWidget);

      final Finder matchesScrollViewFinder = find.byType(MatchesScrollView);
      expect(matchesScrollViewFinder, findsOneWidget);
      final MatchesScrollView matchesScrollView = tester.widget<MatchesScrollView>(matchesScrollViewFinder);
      expect(matchesScrollView.matches, isNotEmpty);

      final Finder firstMatchesScrollViewItemFinder = find.byType(MatchesScrollViewItem);
      expect(firstMatchesScrollViewItemFinder, findsWidgets);
      final Finder firstMatchesScrollViewItemInkWellFinder =
          find.descendant(of: firstMatchesScrollViewItemFinder.first, matching: find.byType(InkWell));
      expect(firstMatchesScrollViewItemInkWellFinder, findsOneWidget);
      final InkWell firstMatchesScrollViewItemInkWell = tester.widget<InkWell>(firstMatchesScrollViewItemInkWellFinder);
      expect(firstMatchesScrollViewItemInkWell.onTap, isNotNull);
    });

    testWidgets("Tapping returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat", null);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(ChatScreen), findsOneWidget);

      final Finder firstMatchesScrollViewItemFinder = find.byType(MatchesScrollViewItem);
      expect(firstMatchesScrollViewItemFinder, findsWidgets);
      final Finder firstMatchesScrollViewItemInkWellFinder =
          find.descendant(of: firstMatchesScrollViewItemFinder.first, matching: find.byType(InkWell));
      expect(firstMatchesScrollViewItemInkWellFinder, findsOneWidget);
      final InkWell firstMatchesScrollViewItemInkWell = tester.widget<InkWell>(firstMatchesScrollViewItemInkWellFinder);
      expect(() => firstMatchesScrollViewItemInkWell.onTap!(), returnsNormally);
    });
  });

  group("RecentChatsScrollViewItem:", () {
    testWidgets("Contains correct information", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat", null);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(ChatScreen), findsOneWidget);

      final Finder chatsFinder = find.byType(RecentChats);
      expect(chatsFinder, findsOneWidget);

      final Finder chatsScrollViewFinder = find.byType(RecentChatsScrollView);
      expect(chatsScrollViewFinder, findsOneWidget);
      final RecentChatsScrollView chatsScrollView = tester.widget<RecentChatsScrollView>(chatsScrollViewFinder);
      expect(chatsScrollView.chats, isNotEmpty);

      final Finder firstChatItemFinder = find.byType(RecentChatsScrollViewItem);
      expect(firstChatItemFinder, findsWidgets);
      final Finder firstChatItemInkWellFinder = find.descendant(of: firstChatItemFinder.first, matching: find.byType(InkWell));
      expect(firstChatItemInkWellFinder, findsOneWidget);
      final InkWell firstChatItemInkWell = tester.widget<InkWell>(firstChatItemInkWellFinder);
      expect(firstChatItemInkWell.onTap, isNotNull);
    });

    testWidgets("Tapping returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat", null);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(ChatScreen), findsOneWidget);
      final Finder firstChatItemFinder = find.byType(RecentChatsScrollViewItem);
      expect(firstChatItemFinder, findsWidgets);
      final Finder firstChatItemInkWellFinder = find.descendant(of: firstChatItemFinder.first, matching: find.byType(InkWell));
      expect(firstChatItemInkWellFinder, findsOneWidget);
      final InkWell firstChatItemInkWell = tester.widget<InkWell>(firstChatItemInkWellFinder);
      expect(() => firstChatItemInkWell.onTap!(), returnsNormally);
    });
  });

  group("ProfileAppBarButton:", () {
    testWidgets("Contains correct information", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat/chat-thread", testMatch);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(ChatThreadScreen), findsOneWidget);

      final Finder profileAppBarButtonFinder = find.byType(ProfileAppBarButton);
      expect(profileAppBarButtonFinder, findsOneWidget);
      final Finder profileAppBarButtonInkWellFinder = find.descendant(of: profileAppBarButtonFinder, matching: find.byType(InkWell));
      expect(profileAppBarButtonInkWellFinder, findsOneWidget);
      final InkWell profileAppBarButtonInkWell = tester.widget<InkWell>(profileAppBarButtonInkWellFinder);
      expect(profileAppBarButtonInkWell.onTap, isNotNull);
    });

    testWidgets("Tapping returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat/chat-thread", testMatch);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(ChatThreadScreen), findsOneWidget);

      final Finder profileAppBarButtonFinder = find.byType(ProfileAppBarButton);
      expect(profileAppBarButtonFinder, findsOneWidget);
      final Finder profileAppBarButtonInkWellFinder = find.descendant(of: profileAppBarButtonFinder, matching: find.byType(InkWell));
      expect(profileAppBarButtonInkWellFinder, findsOneWidget);
      final InkWell profileAppBarButtonInkWell = tester.widget<InkWell>(profileAppBarButtonInkWellFinder);
      expect(() => profileAppBarButtonInkWell.onTap!(), returnsNormally);
    });
  });

  group("MessageComposer:", () {
    testWidgets("Contains correct information", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat/chat-thread", testMatch);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(ChatThreadScreen), findsOneWidget);

      final Finder messageComposerFinder = find.byType(MessageComposer);
      expect(messageComposerFinder, findsOneWidget);

      final Finder messageComposerSendButtonFinder = find.descendant(of: messageComposerFinder, matching: find.byType(TextButton));
      expect(messageComposerSendButtonFinder, findsOneWidget);

      final TextButton messageComposerSendButton = tester.widget<TextButton>(messageComposerSendButtonFinder);
      expect(messageComposerSendButton.onPressed, isNotNull);

      final Finder messageComposerTextFieldFinder = find.descendant(of: messageComposerFinder, matching: find.byType(TextField));
      expect(messageComposerTextFieldFinder, findsOneWidget);

      final TextField messageComposerTextField = tester.widget<TextField>(messageComposerTextFieldFinder);
      expect(messageComposerTextField.controller, isNotNull);
    });
    testWidgets("Tapping send with no text in TextField returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat/chat-thread", testMatch);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(ChatThreadScreen), findsOneWidget);

      final Finder messageComposerFinder = find.byType(MessageComposer);
      expect(messageComposerFinder, findsOneWidget);
      final Finder messageComposerSendButtonFinder = find.descendant(of: messageComposerFinder, matching: find.byType(TextButton));
      expect(messageComposerSendButtonFinder, findsOneWidget);
      final TextButton messageComposerSendButton = tester.widget<TextButton>(messageComposerSendButtonFinder);
      expect(() => messageComposerSendButton.onPressed!(), returnsNormally);
    });

    testWidgets("Tapping send with some text in TextField returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat/chat-thread", testMatch);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(ChatThreadScreen), findsOneWidget);

      final Finder messageComposerFinder = find.byType(MessageComposer);
      expect(messageComposerFinder, findsOneWidget);

      final Finder messageComposerTextFieldFinder = find.descendant(of: messageComposerFinder, matching: find.byType(TextField));
      expect(messageComposerTextFieldFinder, findsOneWidget);
      await tester.enterText(messageComposerTextFieldFinder, "This is a message!");

      final Finder messageComposerSendButtonFinder = find.descendant(of: messageComposerFinder, matching: find.byType(TextButton));
      expect(messageComposerSendButtonFinder, findsOneWidget);
      final TextButton messageComposerSendButton = tester.widget<TextButton>(messageComposerSendButtonFinder);
      expect(() => messageComposerSendButton.onPressed!(), returnsNormally);
    });
  });
}
