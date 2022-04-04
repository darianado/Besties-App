import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/screens/home/chat/chat_thread_screen.dart';
import 'package:project_seg/screens/home/chat/components/chat_conversation.dart';
import 'package:project_seg/screens/home/chat/components/message_composer.dart';
import 'package:project_seg/screens/home/chat/components/profile_app_bar_button.dart';

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

  group("Chat thread screen:", () {
    testWidgets("Contains correct information", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat/chat-thread", testMatch);

      expect(find.byType(ChatThreadScreen), findsOneWidget);

      final Finder profileAppBarButtonFinder = find.byType(ProfileAppBarButton);
      expect(profileAppBarButtonFinder, findsOneWidget);
      final ProfileAppBarButton profileAppBarButton = tester.widget<ProfileAppBarButton>(profileAppBarButtonFinder);
      expect(profileAppBarButton.userMatch, testMatch);

      final Finder chatConversationFinder = find.byType(ChatConversation);
      expect(chatConversationFinder, findsOneWidget);
      final ChatConversation chatConversation = tester.widget<ChatConversation>(chatConversationFinder);
      expect(chatConversation.userMatch, testMatch);

      final Finder messageComposerFinder = find.byType(MessageComposer);
      expect(messageComposerFinder, findsOneWidget);
      final MessageComposer messageComposer = tester.widget<MessageComposer>(messageComposerFinder);
      expect(messageComposer.matchID, testMatch.matchID);
    });
  });
}
