import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/dialogs/match_alert.dart';
import 'package:project_seg/screens/components/images/circle_cached_image.dart';

import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData peterUser = appUsersTestData[1]['data'] as UserData;

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group('Match dialog widget:', () {
    testWidgets("Contains required information", (tester) async {
      await _widgetPumper.pumpWidget(tester, MatchDialog(otherUser: peterUser));

      expect(find.textContaining("It's a match"), findsOneWidget);

      final Finder goToMatchesButtonFinder = find.byType(PillButtonFilled);
      expect(goToMatchesButtonFinder, findsOneWidget);
      final PillButtonFilled goToMatchesButton = tester.widget<PillButtonFilled>(goToMatchesButtonFinder);
      expect(goToMatchesButton.text, "Go to matches");

      final Finder imagesFinder = find.byType(CircleCachedImage);
      expect(imagesFinder, findsNWidgets(2));
    });
  });
}
