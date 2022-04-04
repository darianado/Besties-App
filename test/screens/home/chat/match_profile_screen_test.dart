import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/home/chat/components/chat_button.dart';
import 'package:project_seg/screens/home/chat/match_profile_screen.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';

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

  group("Match profile screen:", () {
    testWidgets("Contains correct information", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat/match-profile", testMatch);

      await tester.pump(Duration(seconds: 2));

      expect(find.byType(MatchProfileScreen), findsOneWidget);

      final Finder profileInformationFinder = find.byType(ProfileInformation);
      expect(profileInformationFinder, findsOneWidget);
      final ProfileInformation profileInformation = tester.widget<ProfileInformation>(profileInformationFinder);
      expect(profileInformation.userData, testMatch.match);

      final Finder openChatButtonFinder = find.byType(OpenChatButton);
      expect(openChatButtonFinder, findsOneWidget);

      final Finder closeButtonFinder = find.byType(RoundActionButton);
      expect(closeButtonFinder, findsOneWidget);
      final RoundActionButton closeButton = tester.widget<RoundActionButton>(closeButtonFinder);
      expect(closeButton.onPressed, isNotNull);
    });

    testWidgets("Tapping open chat returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat/match-profile", testMatch);

      await tester.pump(Duration(seconds: 2));

      expect(find.byType(MatchProfileScreen), findsOneWidget);

      final Finder openChatButtonFinder = find.byType(OpenChatButton);
      expect(openChatButtonFinder, findsOneWidget);
      final OpenChatButton openChatButton = tester.widget<OpenChatButton>(openChatButtonFinder);
      expect(() => openChatButton.onPressed(), returnsNormally);
    });

    testWidgets("Tapping close returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/chat/match-profile", testMatch);

      await tester.pump(Duration(seconds: 2));

      expect(find.byType(MatchProfileScreen), findsOneWidget);

      final Finder closeButtonFinder = find.byType(RoundActionButton);
      expect(closeButtonFinder, findsOneWidget);
      final RoundActionButton closeButton = tester.widget<RoundActionButton>(closeButtonFinder);
      expect(() => closeButton.onPressed!(), returnsNormally);
    });
  });
}
