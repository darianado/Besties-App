import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_dropdown.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_interests.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_textfield.dart';
import 'package:project_seg/screens/components/dialogs/match_alert.dart';
import 'package:project_seg/screens/components/images/circle_cached_image.dart';
import 'package:project_seg/screens/components/interests/select_interests.dart';

import '../../../test_resources/test_profile.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData johnUser = appUsersTestData[0]['data'] as UserData;
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
