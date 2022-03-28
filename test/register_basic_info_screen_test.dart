import 'package:flutter/material.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_seg/router/routes.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'mock.dart';
//import 'test_resources/WidgetPumper.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';



Widget createRegisterBasicInfoScreen(userdata) => MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<UserState>(
              lazy: false,
              create: (BuildContext context) => UserState.instance,
            ),
            Provider<AppRouter>(
              lazy: false,
              create: (BuildContext context) => AppRouter(UserState.instance),
            ),
            ChangeNotifierProvider<ContextState>(
              lazy: false,
              create: (BuildContext context) => ContextState.instance,
            ),
            ChangeNotifierProvider<FeedContentController>(
              lazy: false,
              create: (context) => FeedContentController.instance,
            ),
          ],
          child: Builder(
            builder: (_) =>
                RegisterBasicInfoScreen(userData: userdata),
          ),
        ),
      ),
    ); 


    _createRegisterBasicInfoScreen(WidgetTester tester)async {
      UserData currentUserData = UserData();
      await tester.pumpWidget(createRegisterBasicInfoScreen(currentUserData),
      );
    }



void main() {

  group ('register basic info screen tests', () {
    setupFirebaseAuthMocks();


    //UserData currentUserData = UserData();

    setUpAll(() async {
      await Firebase.initializeApp();
      //inal TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();
    });

  


    testWidgets('basic sign up page has all the field names', (WidgetTester tester) async {


      //await tester.pumpWidget(createRegisterBasicInfoScreen(currentUserData));
      await  _createRegisterBasicInfoScreen(tester);

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


      final Finder gender = find.text('GENDER');
      expect(gender, findsOneWidget);
      final Finder maleText = find.byType(Icon);
      //, FontAwesomeIcons.venusMars);
      expect(maleText, findsWidgets);
      /* final Finder femaleText = find.byIcon(FontAwesomeIcons.venus);
      expect(femaleText, findsOneWidget); */
      /* final Finder otherText = find.widgetWithText(IconData, 'other');
      expect(otherText, findsOneWidget); */


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

    testWidgets('basic sign up page has two text fields', (WidgetTester tester) async {

      
      /* //await tester.pumpWidget(createRegisterBasicInfoScreen(currentUserData));
      await _createRegisterBasicInfoScreen(tester);

      expect(find.byType(TextField), findsWidgets);
      expect(find.widgetWithText(TextField, 'First name'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Last name'), findsOneWidget); */

    }); 



    /* testWidgets('Enter text', (WidgetTester tester) async {
      await _createRegisterBasicInfoScreen(tester);

      final Finder firstName = find.widgetWithText(TextField, 'First name');
      final Finder lastName = find.widgetWithText(TextField, 'First name');

      await tester.enterText(firstName, 'Amy');
      await tester.enterText(lastName, 'Garcia');

      await tester.tap(find.text('next'));

      expect(find.text('Amy'), findsOneWidget);
      expect(find.text('Garcia'), findsOneWidget);

    }); */




  });
  
  
}