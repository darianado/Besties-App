import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_textfield.dart';
import '../../../test_resources/firebase_mocks.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/test_profile.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;
  String userEmail = "johndoe@example.org";
  String buttonText = "Sign out";

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group('Pill button filled widget:', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(
          tester,
          PillButtonFilled(
            text: buttonText,
            onPressed: () => {},
          ));
      await tester.pumpAndSettle();

      expect(find.text(buttonText), findsOneWidget);
    });

    testWidgets('Behaves correctly when tapped', (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidget(
          tester,
          PillButtonFilled(
            text: buttonText,
            onPressed: () async {
              await _widgetPumper.firebaseEnv.userState.signOut();
            },
          ));

      expect(find.text(buttonText), findsOneWidget);

      await tester.tap(find.text(buttonText));
      await tester.pump(const Duration(milliseconds: 500));

      expect(_widgetPumper.firebaseEnv.userState.user?.user?.uid, isNull);
    });

    testWidgets("Shows loading indicator if isLoading is set", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidget(
          tester,
          PillButtonFilled(
            text: buttonText,
            isLoading: true,
            onPressed: () async {
              await _widgetPumper.firebaseEnv.userState.signOut();
            },
          ));

      expect(find.text(buttonText), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
