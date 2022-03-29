import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/email_verify/email_verify_screen.dart';

import '../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup();
  });

  group("Email verify screen tests:", () {
    testWidgets('Test email verify screen displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, const EmailVerifyScreen());

      await tester.idle();
      await tester.pump();

      expect(find.textContaining("seg-djangoals@example.org"), findsOneWidget);

      final Finder resendEmailButtonFinder = find.widgetWithText(PillButtonOutlined, "Resend email");
      expect(resendEmailButtonFinder, findsOneWidget);

      final resendEmailButton = tester.widget<PillButtonOutlined>(resendEmailButtonFinder);
      expect(resendEmailButton.color, whiteColour);
      expect(resendEmailButton.onPressed, isNotNull);
      expect(resendEmailButton.textStyle?.color, whiteColour);

      expect(find.byType(Lottie), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });
  });
}
