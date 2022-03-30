import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/email_verify/email_verify_screen.dart';
import 'package:project_seg/screens/login/login_screen.dart';

import '../helpers.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "janedoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Email verify screen:", () {
    testWidgets('Contains correct information', (tester) async {
      await signInHelper(_widgetPumper, userEmail, "Password123");
      await _widgetPumper.pumpWidgetRouter(tester, verifyEmailScreenPath);

      expect(find.byType(EmailVerifyScreen), findsOneWidget);

      expect(find.textContaining(userEmail), findsOneWidget);

      final Finder resendEmailButtonFinder = find.widgetWithText(PillButtonOutlined, "Resend email");
      expect(resendEmailButtonFinder, findsOneWidget);

      final resendEmailButton = tester.widget<PillButtonOutlined>(resendEmailButtonFinder);
      expect(resendEmailButton.color, whiteColour);
      expect(resendEmailButton.onPressed, isNotNull);
      expect(resendEmailButton.textStyle?.color, whiteColour);

      final Finder lottieFinder = find.byType(Lottie);
      expect(lottieFinder, findsOneWidget);

      final Lottie lottie = tester.widget<Lottie>(lottieFinder);
      expect(lottie.animate, true);

      final Finder lottieContainerFinder = find.ancestor(of: lottieFinder, matching: find.byType(SizedBox));
      expect(lottieContainerFinder, findsWidgets);

      final SizedBox lottieContainer = tester.widget<SizedBox>(lottieContainerFinder.first);
      expect(lottieContainer.height, 300);
      expect(lottieContainer.height, 300);

      final Finder logOutButtonFinder = find.byType(IconButton);
      expect(logOutButtonFinder, findsOneWidget);

      final IconButton logOutButton = tester.widget<IconButton>(logOutButtonFinder);
      expect(logOutButton.onPressed, isNotNull);

      expect(logOutButton.icon, isA<Icon>());
      final Icon logOutButtonIcon = (logOutButton.icon as Icon);
      expect(logOutButtonIcon, isNotNull);
      expect(logOutButtonIcon.color, whiteColour);
      expect(logOutButtonIcon.icon, FontAwesomeIcons.signOutAlt);
    });

    testWidgets("Clicking log out button logs out", (tester) async {
      await signInHelper(_widgetPumper, userEmail, "Password123");
      await _widgetPumper.pumpWidgetRouter(tester, verifyEmailScreenPath);

      expect(find.byType(EmailVerifyScreen), findsOneWidget);
      expect(_widgetPumper.firebaseEnv.userState.user?.user?.uid, isNotNull);

      final Finder logOutButtonFinder = find.byType(IconButton);
      expect(logOutButtonFinder, findsOneWidget);

      final IconButton logOutButton = tester.widget<IconButton>(logOutButtonFinder);
      expect(logOutButton.onPressed, isNotNull);

      expect(() => logOutButton.onPressed!(), returnsNormally);

      await tester.pumpAndSettle();

      expect(find.byType(LogInScreen), findsOneWidget);

      expect(_widgetPumper.firebaseEnv.userState.user?.user?.uid, isNull);
    });

    testWidgets("Clicking resend email does not crash", (tester) async {
      await signInHelper(_widgetPumper, userEmail, "Password123");
      await _widgetPumper.pumpWidgetRouter(tester, verifyEmailScreenPath);

      expect(find.byType(EmailVerifyScreen), findsOneWidget);

      final Finder resendEmailButtonFinder = find.widgetWithText(PillButtonOutlined, "Resend email");
      expect(resendEmailButtonFinder, findsOneWidget);

      final resendEmailButton = tester.widget<PillButtonOutlined>(resendEmailButtonFinder);
      expect(resendEmailButton.onPressed, isNotNull);

      expect(() => resendEmailButton.onPressed(), returnsNormally);

      await tester.pump();

      expect(find.byType(EmailVerifyScreen), findsOneWidget);
    });
  });
}
