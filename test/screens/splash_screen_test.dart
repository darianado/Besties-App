import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/constants/borders.dart';
import 'package:project_seg/screens/splash/splash_screen.dart';

import '../test_resources/helpers.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Splash screen:", () {
    testWidgets("Contains correct content", (tester) async {
      await _widgetPumper.firebaseEnv.userState.resetUserState();
      await _widgetPumper.pumpWidgetRouter(tester, "/splash", null);

      expect(find.byType(SplashScreen), findsOneWidget);

      final Finder progressIndicatorFinder = find.byType(CircularProgressIndicator);
      expect(progressIndicatorFinder, findsOneWidget);
    });
  });
}
