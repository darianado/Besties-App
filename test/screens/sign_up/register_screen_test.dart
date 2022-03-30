import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_resources/widget_pumper.dart';
import 'package:project_seg/screens/sign_up/register_screen.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';


void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "janedoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

    testWidgets('Register Screen Contains correct information', (tester) async {
       await _widgetPumper.pumpWidget(tester, const RegisterScreen());

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

      final Finder comfirmPasswordText = find.text('Confirm password');
      expect(comfirmPasswordText, findsOneWidget);
      final Finder comfirmPasswordWidget = find.widgetWithText(TextFormField, 'Confirm password');
      expect(comfirmPasswordWidget, findsOneWidget);

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
  
}