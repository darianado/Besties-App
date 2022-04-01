import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/dialogs/dismiss_dialog.dart';
import 'package:project_seg/screens/log_in/login_screen.dart';
import 'package:project_seg/screens/recover_password/recover_password_screen.dart';
import 'package:project_seg/states/user_state.dart';

import '../test_resources/helpers.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Recover password screen:", () {
    testWidgets("Contains correct information", (tester) async {
      await signOutHelper(_widgetPumper);

      await _widgetPumper.pumpWidgetRouter(tester, recoverPasswordScreenPath, null);

      expect(find.byType(RecoverPasswordScreen), findsOneWidget);

      expect(find.textContaining("Forgot Password?"), findsOneWidget);

      final Finder lottieFinder = find.byType(Lottie);
      expect(lottieFinder, findsOneWidget);

      final Lottie lottie = tester.widget<Lottie>(lottieFinder);
      expect(lottie.animate, true);

      final Finder emailTextFieldFinder = find.byType(TextFormField);
      expect(emailTextFieldFinder, findsOneWidget);

      final TextFormField emailTextField = tester.widget<TextFormField>(emailTextFieldFinder);
      expect(emailTextField.controller, isNotNull);
      expect(emailTextField.controller?.text, isEmpty);

      final Finder recoveryEmailButtonFinder = find.widgetWithText(PillButtonFilled, "Send recovery email");
      expect(recoveryEmailButtonFinder, findsOneWidget);

      final recoveryEmailButton = tester.widget<PillButtonFilled>(recoveryEmailButtonFinder);
      expect(recoveryEmailButton.backgroundColor, tertiaryColour);
      expect(recoveryEmailButton.onPressed, isNotNull);
      expect(recoveryEmailButton.textStyle?.color, whiteColour);

      final Finder returnToLoginButtonFinder = find.widgetWithText(PillButtonOutlined, "Return to log in");
      expect(returnToLoginButtonFinder, findsOneWidget);

      final returnToLoginButton = tester.widget<PillButtonOutlined>(returnToLoginButtonFinder);
      expect(returnToLoginButton.color, tertiaryColour);
      expect(returnToLoginButton.onPressed, isNotNull);
    });

    testWidgets("Clicking send recovery email with no email shows error", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, recoverPasswordScreenPath, null);

      expect(find.byType(RecoverPasswordScreen), findsOneWidget);

      final Finder recoveryEmailButtonFinder = find.widgetWithText(PillButtonFilled, "Send recovery email");
      expect(recoveryEmailButtonFinder, findsOneWidget);

      final recoveryEmailButton = tester.widget<PillButtonFilled>(recoveryEmailButtonFinder);

      expect(() => recoveryEmailButton.onPressed(), returnsNormally);

      await tester.pump();

      expect(find.textContaining("Please check your email is in the right format"), findsOneWidget);
    });

    testWidgets("Clicking send recovery email with invalid email shows error", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, recoverPasswordScreenPath, null);

      expect(find.byType(RecoverPasswordScreen), findsOneWidget);

      final Finder recoveryEmailButtonFinder = find.widgetWithText(PillButtonFilled, "Send recovery email");
      expect(recoveryEmailButtonFinder, findsOneWidget);
      final recoveryEmailButton = tester.widget<PillButtonFilled>(recoveryEmailButtonFinder);

      final Finder emailTextFieldFinder = find.byType(TextFormField);
      expect(emailTextFieldFinder, findsOneWidget);
      final TextFormField emailTextField = tester.widget<TextFormField>(emailTextFieldFinder);

      await tester.enterText(emailTextFieldFinder, "invalid-email.com");

      expect(() => recoveryEmailButton.onPressed(), returnsNormally);

      await tester.pump();

      expect(find.textContaining("Please check your email is in the right format"), findsOneWidget);
    });

    testWidgets("Clicking send recovery email with valid email shows dialog", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, recoverPasswordScreenPath, null);

      expect(find.byType(RecoverPasswordScreen), findsOneWidget);

      final Finder recoveryEmailButtonFinder = find.widgetWithText(PillButtonFilled, "Send recovery email");
      expect(recoveryEmailButtonFinder, findsOneWidget);
      final recoveryEmailButton = tester.widget<PillButtonFilled>(recoveryEmailButtonFinder);

      final Finder emailTextFieldFinder = find.byType(TextFormField);
      expect(emailTextFieldFinder, findsOneWidget);
      final TextFormField emailTextField = tester.widget<TextFormField>(emailTextFieldFinder);

      await tester.enterText(emailTextFieldFinder, "johndoe@example.org");

      expect(() => recoveryEmailButton.onPressed(), returnsNormally);

      await tester.pump();

      expect(find.byType(DismissDialog), findsOneWidget);
    });

    testWidgets("Clicking back to log in button redirects to login screen", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, recoverPasswordScreenPath, null);

      expect(find.byType(RecoverPasswordScreen), findsOneWidget);

      final Finder returnToLoginButtonFinder = find.widgetWithText(PillButtonOutlined, "Return to log in");
      expect(returnToLoginButtonFinder, findsOneWidget);

      final returnToLoginButton = tester.widget<PillButtonOutlined>(returnToLoginButtonFinder);

      expect(() => returnToLoginButton.onPressed(), returnsNormally);

      await tester.pumpAndSettle();

      expect(find.byType(LogInScreen), findsOneWidget);
    });
  });
}
