import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_textfield.dart';
import '../mock.dart';

import '../test_resources/test_profile.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup();
  });

  OtherUser firstProfile = TestProfile.firstProfile;

  group('EditDialogTextField Widget tests', () {
    testWidgets('Test EditDialogTextField Widget saves new fields once edited', (tester) async {
      String newBio = "My new Bio!";
      String oldBio = firstProfile.userData.bio!;

      await _widgetPumper.pumpWidget(
        tester,
        EditDialogTextField(
          key: const ValueKey("key"),
          value: firstProfile.userData.bio!,
          onSave: (_, bio) {
            firstProfile.userData.bio = bio;
          },
        ),
      );

      expect(find.text(oldBio), findsOneWidget);
      expect(find.text(newBio), findsNothing);

      await tester.tap(find.text(oldBio));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(TextField), findsOneWidget);
      await tester.enterText(find.byType(TextField), newBio);

      await tester.tap(find.text("Save"));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text(newBio), findsOneWidget);
      expect(find.text(oldBio), findsNothing);
    });
  });
}
