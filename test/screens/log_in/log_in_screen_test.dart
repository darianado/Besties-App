import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/log_in/login_screen.dart';

import '../../test_resources/helpers.dart';
import '../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group("Log in screen:", () {
    testWidgets('log in page has all the field widgets', (WidgetTester tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, "/login", null);

      expect(find.byType(LogInScreen), findsOneWidget);

      expect(find.text('Log in'), findsWidgets);

      final Finder emailTextFinder = find.text('Email address');
      expect(emailTextFinder, findsOneWidget);
      final Finder emailTextFieldFinder = find.widgetWithText(TextField, 'Email address');
      expect(emailTextFieldFinder, findsOneWidget);

      final Finder passwordTextFinder = find.text('Password');
      expect(passwordTextFinder, findsOneWidget);
      final Finder passwordTextFieldFinder = find.widgetWithText(TextField, 'Password');
      expect(passwordTextFieldFinder, findsOneWidget);

      final Finder forgetPasswordTextFinder = find.text('Forgot password?');
      expect(forgetPasswordTextFinder, findsOneWidget);

      final Finder signUpTextFinder = find.text('Don\'t have an account?');
      expect(signUpTextFinder, findsOneWidget);
      final Finder signUpButtonFinder = find.widgetWithText(PillButtonOutlined, 'Sign up');
      expect(signUpButtonFinder, findsOneWidget);

      expect(find.byType(TextField), findsWidgets);
      expect(find.widgetWithText(TextField, 'Email address'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

      //text field only takes one value
      await tester.enterText(emailTextFieldFinder, 'dd@yahoo.com');
      await tester.enterText(passwordTextFieldFinder, '123456');

      await tester.pump();

      expect(find.text('dd@yahoo.com'), findsOneWidget);
      final inputPassword = tester.firstWidget<EditableText>(find.text('123456'));
      expect(inputPassword.obscureText, true);

      await tester.enterText(emailTextFieldFinder, 'abc@yahoo.com');

      await tester.pump();

      expect(find.text('dd@yahoo.com'), findsNothing);
      expect(find.text('abc@yahoo.com'), findsOneWidget);
    });

    testWidgets("Tapping forgot password button returns normally", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, "/login", null);

      expect(find.byType(LogInScreen), findsOneWidget);

      final Finder forgotPasswordButtonFinder = find.widgetWithText(TextButton, 'Forgot password?');
      expect(forgotPasswordButtonFinder, findsOneWidget);
      final TextButton forgotPasswordButton = tester.widget<TextButton>(forgotPasswordButtonFinder);
      expect(forgotPasswordButton.onPressed, isNotNull);
      expect(() => forgotPasswordButton.onPressed!(), returnsNormally);
    });

    testWidgets("Tapping log in button with no input returns normally", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, "/login", null);

      expect(find.byType(LogInScreen), findsOneWidget);

      final Finder logInButtonFinder = find.widgetWithText(PillButtonFilled, 'Log in');
      expect(logInButtonFinder, findsOneWidget);
      final PillButtonFilled logInButton = tester.widget<PillButtonFilled>(logInButtonFinder);
      expect(() => logInButton.onPressed(), returnsNormally);
    });

    testWidgets("Tapping log in button with invalid input returns normally", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, "/login", null);

      expect(find.byType(LogInScreen), findsOneWidget);

      final Finder emailTextFieldFinder = find.widgetWithText(TextField, 'Email address');
      expect(emailTextFieldFinder, findsOneWidget);

      final Finder passwordTextFieldFinder = find.widgetWithText(TextField, 'Password');
      expect(passwordTextFieldFinder, findsOneWidget);

      await tester.enterText(emailTextFieldFinder, "abc");
      await tester.enterText(passwordTextFieldFinder, "pass");

      final Finder logInButtonFinder = find.widgetWithText(PillButtonFilled, 'Log in');
      expect(logInButtonFinder, findsOneWidget);
      final PillButtonFilled logInButton = tester.widget<PillButtonFilled>(logInButtonFinder);
      expect(() => logInButton.onPressed(), returnsNormally);
    });

    testWidgets("Tapping log in button with valid input returns normally", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, "/login", null);

      expect(find.byType(LogInScreen), findsOneWidget);

      final Finder emailTextFieldFinder = find.widgetWithText(TextField, 'Email address');
      expect(emailTextFieldFinder, findsOneWidget);

      final Finder passwordTextFieldFinder = find.widgetWithText(TextField, 'Password');
      expect(passwordTextFieldFinder, findsOneWidget);

      await tester.enterText(emailTextFieldFinder, "abc@abc.com");
      await tester.enterText(passwordTextFieldFinder, "pass");

      final Finder logInButtonFinder = find.widgetWithText(PillButtonFilled, 'Log in');
      expect(logInButtonFinder, findsOneWidget);
      final PillButtonFilled logInButton = tester.widget<PillButtonFilled>(logInButtonFinder);
      expect(() => logInButton.onPressed(), returnsNormally);
    });

    testWidgets("Tapping button to go to sign up returns normally", (tester) async {
      await signOutHelper(_widgetPumper);
      await _widgetPumper.pumpWidgetRouter(tester, "/login", null);

      expect(find.byType(LogInScreen), findsOneWidget);

      final Finder signUpButtonFinder = find.widgetWithText(PillButtonOutlined, 'Sign up');
      expect(signUpButtonFinder, findsOneWidget);
      final PillButtonOutlined signUpButton = tester.widget<PillButtonOutlined>(signUpButtonFinder);
      expect(() => signUpButton.onPressed(), returnsNormally);
    });
  });
}
