import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/interests_in_common.dart';

import '../../test_resources/helpers.dart';
import '../../test_resources/testing_data.dart';
import '../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData johnTestUser = appUsersTestData[0]['data'] as UserData;
  UserData peterTestUser = appUsersTestData[1]['data'] as UserData;
  UserData janeTestUser = appUsersTestData[2]['data'] as UserData;
  UserData emmaTestUser = appUsersTestData[4]['data'] as UserData;
  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Interests in common widget:", () {
    testWidgets("Only one thing in common results in the right text", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidget(tester, InterestsInCommon(user: johnTestUser, otherUser: peterTestUser));

      expect(find.textContaining("YOU HAVE"), findsOneWidget);
      expect(find.textContaining("1"), findsOneWidget);
      expect(find.textContaining("INTEREST IN COMMON"), findsOneWidget);
    });

    testWidgets("Multiple things in common results in the right text", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidget(tester, InterestsInCommon(user: johnTestUser, otherUser: janeTestUser));

      expect(find.textContaining("YOU HAVE"), findsOneWidget);
      expect(find.textContaining("NO"), findsNothing);
      expect(find.textContaining("INTERESTS IN COMMON"), findsOneWidget);
    });

    testWidgets("No things in common results in the right text", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidget(tester, InterestsInCommon(user: johnTestUser, otherUser: emmaTestUser));

      expect(find.textContaining("YOU HAVE"), findsOneWidget);
      expect(find.textContaining("NO"), findsOneWidget);
      expect(find.textContaining("INTERESTS IN COMMON"), findsOneWidget);
    });
  });
}
