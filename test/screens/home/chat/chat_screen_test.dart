import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/home/chat/chat_screen.dart';
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

      expect(find.byType(ChatScreen), findsOneWidget);

      expect(find.textContaining("New matches"), findsOneWidget);
      expect(find.textContaining("Chats"), findsOneWidget);
      expect(find.byType(Matches), findsOneWidget);
      expect(find.byType(RecentChats), findsOneWidget);

      final Finder pageContainerFinder = find.ancestor(of: find.byType(Matches), matching: find.byType(Container)).first;
      expect(pageContainerFinder, findsOneWidget);
      final Container pageContainer = tester.widget<Container>(pageContainerFinder);
      expect(pageContainer.decoration, isNotNull);
      expect(pageContainer.decoration, isA<BoxDecoration>());
      final BoxDecoration boxDecoration = pageContainer.decoration as BoxDecoration;
      expect(boxDecoration.gradient, isNotNull);
      expect(boxDecoration.gradient!.stops, containsAll([0.4, 0.8, 1]));
      expect(boxDecoration.gradient!.colors, containsAll([whiteColour, whiteColourShade2, whiteColourShade3]));
    });
  });
}
