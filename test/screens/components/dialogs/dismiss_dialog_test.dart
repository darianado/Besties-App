import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/dialogs/dismiss_dialog.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_textfield.dart';

import 'package:project_seg/constants/colours.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/home/profile/edit_password_screen.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/screens/home/profile/profile_screen.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";
  const String dialogMessage = "dialog message";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group('DismissDialog widget tests', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester,
        DismissDialog(
          key: const ValueKey("key"),
          message: dialogMessage,
        ),
      );

      expect(find.text(dialogMessage), findsOneWidget);

      final Finder dismissButtonFinder = find.widgetWithText(PillButtonFilled, "Dismiss");
      expect(dismissButtonFinder, findsOneWidget);

      final PillButtonFilled dismissButton = tester.widget<PillButtonFilled>(
          dismissButtonFinder);
      expect(dismissButton.onPressed, isNotNull);
      expect(dismissButton.textStyle?.color, whiteColour);
    });

      testWidgets('Clicking dismiss button dismisses dialog', (tester) async {

        await _widgetPumper.pumpWidget(tester,
          DismissDialog(
            key: const ValueKey("key"),
            message: dialogMessage,
          ),
        );

        expect(find.byType(DismissDialog), findsOneWidget);

        final Finder dismissButtonFinder = find.byType(PillButtonFilled);
        expect(dismissButtonFinder, findsOneWidget);

       final PillButtonFilled dismissButton = tester.widget<PillButtonFilled>(dismissButtonFinder);
       expect(dismissButton.onPressed, isNotNull);

        expect(() => dismissButton.onPressed(), returnsNormally);

        await tester.pumpAndSettle();

        expect(find.byType(DismissDialog), findsNothing);
      });
    });
}