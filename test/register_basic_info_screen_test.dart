import 'package:flutter/material.dart';
//import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_seg/models/User/user_data.dart';

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

    testWidgets('basic sign up page has all the field widgets', (WidgetTester tester) async {
      ValueKey key = const ValueKey("basic info page test");
      await  WidgetPumper.pumpRegisterBasicInfoScreen(tester, key, currentUserData);

      expect(find.text('Let\'s start with the basics...'), findsOneWidget);

      final Finder firstNameText = find.text('First name');
      expect(firstNameText, findsOneWidget);
      final Finder firstName = find.widgetWithText(TextField, 'First name');
      expect(firstName, findsOneWidget);

      final Finder lastNameText = find.text('Last name');
      expect(lastNameText, findsOneWidget);
      final Finder lastName = find.widgetWithText(TextField, 'Last name');
      expect(lastName, findsOneWidget);

      final Finder numberOfChipWidgets = find.byType(ChipWidget);
      expect(numberOfChipWidgets, findsWidgets);

      final Finder birthday = find.text('BIRTHDAY');
      expect(birthday, findsOneWidget);
      final Finder birthdaySelectButton = find.widgetWithText(ChipWidget, 'Select a date');
      expect(birthdaySelectButton, findsOneWidget);


      final Finder genderText = find.text('GENDER');
      expect(genderText, findsOneWidget);
      final Finder genderIcon = find.byType(Icon);
      expect(genderIcon, findsWidgets);

      /* final Finder defaultGender = find.byIcon(FontAwesomeIcons.venus);
      expect(defaultGender, findsOneWidget);
      
      final Finder maleGender = find.byIcon(FontAwesomeIcons.mars);
      expect(maleGender, findsOneWidget);

      final Finder femaleGender = find.byIcon(FontAwesomeIcons.venus);
      expect(femaleGender, findsOneWidget); */


      final Finder relationshipStatus = find.text ('RELATIONSHIP STATUS');
      expect(relationshipStatus, findsOneWidget);
      final Finder selectButton = find.widgetWithText(RelationshipStatusButton, 'Click to select');
      expect(selectButton, findsOneWidget);

      final Finder nextText = find.text ('Next');
      expect(nextText, findsOneWidget);
      final Finder nextButton = find.widgetWithText(ElevatedButton, 'Next');
      expect(nextButton, findsOneWidget);


      expect(find.byType(TextField), findsWidgets);
      expect(find.widgetWithText(TextField, 'First name'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Last name'), findsOneWidget);


      //text field only takes one value 
      await tester.enterText(firstName, 'Amy');
      await tester.enterText(lastName, 'Garcia');

      await tester.pump();

      expect(find.text('Amy'), findsOneWidget);
      expect(find.text('Garcia'), findsOneWidget);


      await tester.enterText(firstName, 'Peter');
      await tester.enterText(lastName, 'Parker');

      await tester.pump();

      expect(find.text('Amy'), findsNothing);
      expect(find.text('Garcia'), findsNothing);

      expect(find.text('Peter'), findsOneWidget);
      expect(find.text('Parker'), findsOneWidget);

    });

  
  
}