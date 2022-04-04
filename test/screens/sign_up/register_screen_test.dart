import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/log_in/login_screen.dart';
import 'package:project_seg/screens/sign_up/register_screen.dart';

import '../../test_resources/helpers.dart';
import '../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "janedoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: false);
  });

  group("Register screen:", () {
    testWidgets('Register Screen Contains correct widgets', (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, registerScreenPath, null);

      final Finder textFinder = find.text('Sign up');
      expect(textFinder, findsOneWidget);

      final Text textStyle = tester.widget<Text>(textFinder);
      expect(textStyle.style?.color, secondaryColour);

      final Finder emailText = find.text('Email address');
      expect(emailText, findsOneWidget);
      final Finder emailAddress = find.widgetWithText(TextFormField, 'Email address');
      expect(emailAddress, findsOneWidget);

      final Finder emailIcon = find.byIcon(Icons.email);
      expect(emailIcon, findsOneWidget);
      final Icon emailIconStyle = tester.widget<Icon>(emailIcon);
      expect(emailIconStyle.color, tertiaryColour);

      final Finder passwordText = find.text('Password');
      expect(passwordText, findsOneWidget);
      final Finder passwordWidget = find.widgetWithText(TextFormField, 'Password');
      expect(passwordWidget, findsOneWidget);

      final Finder lockIcon = find.byIcon(Icons.lock);
      expect(lockIcon, findsWidgets);

      final Finder confirmPasswordText = find.text('Confirm password');
      expect(confirmPasswordText, findsOneWidget);
      final Finder confirmPasswordWidget = find.widgetWithText(TextFormField, 'Confirm password');
      expect(confirmPasswordWidget, findsOneWidget);

      final Finder registerButton = find.widgetWithText(PillButtonFilled, 'Register');
      expect(registerButton, findsOneWidget);

      final registerButtonStyle = tester.widget<PillButtonFilled>(registerButton);
      expect(registerButtonStyle.text, 'Register');
      expect(registerButtonStyle.textStyle!.fontSize, 25);
      expect(registerButtonStyle.textStyle!.fontWeight, FontWeight.w600);

      final registerTextFinder = find.text('Already registered?');
      expect(registerTextFinder, findsOneWidget);

      final Finder loginButton = find.widgetWithText(PillButtonOutlined, "Log in");
      expect(loginButton, findsOneWidget);

      final loginButtonStyle = tester.widget<PillButtonOutlined>(loginButton);
      expect(loginButtonStyle.text, 'Log in');
      expect(loginButtonStyle.color, tertiaryColour);
    });

    testWidgets("Tapping register button with no input returns normally", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, registerScreenPath, null);

      expect(find.byType(RegisterScreen), findsOneWidget);

      final Finder registerButtonFinder = find.widgetWithText(PillButtonFilled, 'Register');
      expect(registerButtonFinder, findsOneWidget);
      final PillButtonFilled registerButton = tester.widget<PillButtonFilled>(registerButtonFinder);
      expect(() => registerButton.onPressed(), returnsNormally);
    });

    testWidgets("Tapping register button with invalid input returns normally", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, registerScreenPath, null);

      expect(find.byType(RegisterScreen), findsOneWidget);

      final Finder emailTextFieldFinder = find.widgetWithText(TextField, 'Email address');
      expect(emailTextFieldFinder, findsOneWidget);

      final Finder passwordTextFieldFinder = find.widgetWithText(TextField, 'Password');
      expect(passwordTextFieldFinder, findsOneWidget);

      final Finder confirmPasswordTextFieldFinder = find.widgetWithText(TextFormField, 'Confirm password');
      expect(confirmPasswordTextFieldFinder, findsOneWidget);

      await tester.enterText(emailTextFieldFinder, "abc");
      await tester.enterText(passwordTextFieldFinder, "pass");
      await tester.enterText(confirmPasswordTextFieldFinder, "anotherPass");

      final Finder registerButtonFinder = find.widgetWithText(PillButtonFilled, 'Register');
      expect(registerButtonFinder, findsOneWidget);
      final PillButtonFilled registerButton = tester.widget<PillButtonFilled>(registerButtonFinder);
      expect(() => registerButton.onPressed(), returnsNormally);
    });

    testWidgets("Tapping register button with valid input returns normally", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, registerScreenPath, null);

      expect(find.byType(RegisterScreen), findsOneWidget);

      final Finder emailTextFieldFinder = find.widgetWithText(TextField, 'Email address');
      expect(emailTextFieldFinder, findsOneWidget);

      final Finder passwordTextFieldFinder = find.widgetWithText(TextField, 'Password');
      expect(passwordTextFieldFinder, findsOneWidget);

      final Finder confirmPasswordTextFieldFinder = find.widgetWithText(TextFormField, 'Confirm password');
      expect(confirmPasswordTextFieldFinder, findsOneWidget);

      await tester.enterText(emailTextFieldFinder, "abc@abc.com");
      await tester.enterText(passwordTextFieldFinder, "Password123");
      await tester.enterText(confirmPasswordTextFieldFinder, "Password123");

      await tester.pump();

      final Finder registerButtonFinder = find.widgetWithText(PillButtonFilled, 'Register');
      expect(registerButtonFinder, findsOneWidget);
      final PillButtonFilled registerButton = tester.widget<PillButtonFilled>(registerButtonFinder);
      expect(() => registerButton.onPressed(), returnsNormally);
    });

    testWidgets("Clicking log in button goes to login page", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, registerScreenPath, null);

      expect(find.byType(RegisterScreen), findsOneWidget);
      expect(_widgetPumper.firebaseEnv.userState.user?.user?.uid, isNull);

      final Finder loginButtonFinder = find.byType(PillButtonOutlined);
      expect(loginButtonFinder, findsOneWidget);

      final PillButtonOutlined logInButton = tester.widget<PillButtonOutlined>(loginButtonFinder);
      expect(logInButton.onPressed, isNotNull);

      expect(() => logInButton.onPressed(), returnsNormally);

      await tester.pumpAndSettle();

      expect(find.byType(LogInScreen), findsOneWidget);

      expect(_widgetPumper.firebaseEnv.userState.user?.user?.uid, isNull);
    });
  });
}
