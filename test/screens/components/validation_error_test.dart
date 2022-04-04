import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/validation_error.dart';

import '../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Validation error widget:", () {
    testWidgets("Contains only Container if errorText is null", (tester) async {
      await _widgetPumper.pumpWidget(tester, const ValidationError(errorText: null));
      expect(find.byType(Row), findsNothing);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets("Contains only Container if errorText is empty string", (tester) async {
      await _widgetPumper.pumpWidget(tester, const ValidationError(errorText: ""));
      expect(find.byType(Row), findsNothing);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets("Contains only correct information for valid errorText", (tester) async {
      await _widgetPumper.pumpWidget(tester, const ValidationError(errorText: "This is some error text."));
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
