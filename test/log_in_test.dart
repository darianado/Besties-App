import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/login/login_screen.dart';
import 'mock.dart';
import 'test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData currentUserData = UserData();

  setUpAll(() async {
    await _widgetPumper.setup();
  });

  testWidgets('log in page has all the field widgets', (WidgetTester tester) async {
    ValueKey key = const ValueKey("basic info page test");
    await _widgetPumper.pumpWidget(tester, LogInScreen());

    expect(find.text('Log in'), findsWidgets);

    final Finder emailText = find.text('Email address');
    expect(emailText, findsOneWidget);
    final Finder email = find.widgetWithText(TextField, 'Email address');
    expect(email, findsOneWidget);

    final Finder passwordText = find.text('Password');
    expect(passwordText, findsOneWidget);
    final Finder password = find.widgetWithText(TextField, 'Password');
    expect(password, findsOneWidget);

    final Finder forgetPasswordText = find.text('Forget password?');
    expect(forgetPasswordText, findsOneWidget);

    final Finder signUpText = find.text('Don\'t have an account?');
    expect(signUpText, findsOneWidget);
    final Finder signUpButton = find.widgetWithText(PillButtonOutlined, 'Sign up');
    expect(signUpButton, findsOneWidget);

    expect(find.byType(TextField), findsWidgets);
    expect(find.widgetWithText(TextField, 'Email address'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

    //text field only takes one value
    await tester.enterText(email, 'dd@yahoo.com');
    await tester.enterText(password, '123456');

    await tester.pump();

    expect(find.text('dd@yahoo.com'), findsOneWidget);
    final inputPassword = tester.firstWidget<EditableText>(find.text('123456'));
    expect(inputPassword.obscureText, true);

    await tester.enterText(email, 'abc@yahoo.com');

    await tester.pump();

    expect(find.text('dd@yahoo.com'), findsNothing);
    expect(find.text('abc@yahoo.com'), findsOneWidget);
  });
}
