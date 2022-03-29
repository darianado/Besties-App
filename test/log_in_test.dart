import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';

import 'mock.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'test_resources/WidgetPumper.dart';


void main() {
  setupFirebaseAuthMocks();
  UserData currentUserData = UserData();

    setUpAll(() async {
      await Firebase.initializeApp();
      //final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    });

    testWidgets('log in page has all the field widgets', (WidgetTester tester) async {
      ValueKey key = const ValueKey("basic info page test");
      await  WidgetPumper.pumpLogInScreen(tester, key);

      expect(find.text('Log in'), findsWidgets);

      final Finder emailText = find.text('Email address');
      expect(emailText, findsOneWidget);
      final Finder email = find.widgetWithText(TextField, 'Email address');
      expect(email, findsOneWidget);

      final Finder passwordText = find.text('Password');
      expect(passwordText, findsOneWidget);
      final Finder password = find.widgetWithText(TextField, 'Password');
      expect(password, findsOneWidget);

      // final Finder numberOfChipWidgets = find.byType(ChipWidget);
      // expect(numberOfChipWidgets, findsWidgets);

      // final Finder logInText = find.text ('Log in');
      // expect(logInText, findsOneWidget);
      // final Finder logInButton = find.widgetWithText(ElevatedButton, 'Log in');
      // expect(logInButton, findsOneWidget);

      final Finder forgetPasswordText = find.text ('Forget password?');
      expect(forgetPasswordText, findsOneWidget);

      final Finder signUpText = find.text ('Don\'t have an account?');
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