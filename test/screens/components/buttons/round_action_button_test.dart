import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  String userEmail = "johndoe@example.org";
  Icon buttonIcon = const Icon(Icons.close);
  group('RoundActionButton Widget tests', () {
    testWidgets('Test RoundActionButton displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, RoundActionButton(child: buttonIcon));

      expect(find.byType(buttonIcon.runtimeType), findsOneWidget);
    });

    testWidgets('Test editable RoundActionButton behaves correctly when tapped', (tester) async {
      await signInHelper(_widgetPumper, userEmail);

      await _widgetPumper.pumpWidget(
        tester,
        RoundActionButton(
          child: buttonIcon,
          onPressed: () async {
            _widgetPumper.firebaseEnv.userState.signOut();
          },
        ),
      );

      expect(find.byType(buttonIcon.runtimeType), findsOneWidget);

      await tester.tap(find.byType(buttonIcon.runtimeType));
      await tester.pump(const Duration(milliseconds: 500));

      expect(_widgetPumper.firebaseEnv.userState.user?.user?.uid, isNull);
    });
  });
}
