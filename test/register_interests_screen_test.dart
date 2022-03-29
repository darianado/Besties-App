import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_seg/screens/sign_up/register_interests_screen.dart';
import 'mock.dart';
import 'test_resources/widget_pumper.dart';

void main(){
  setupFirebaseAuthMocks();
  UserData currentUserData = UserData();

  setUpAll( () async {
    await Firebase.initializeApp();
  });

  testWidgets('interests page has all widgets', (WidgetTester tester) async {
    await WidgetPumper.pumpCustomWidget(tester, RegisterInterestsScreen(userData: currentUserData));

    final Finder iconButton = find.byType(IconButton);
    expect(iconButton, findsOneWidget);

    final Finder textHeaderFinder = find.text('Finally, what do you like?');
    expect(textHeaderFinder, findsOneWidget);

    final Finder textFinder = find.text("It is time to let us know more about your interests.");
    expect(textFinder, findsOneWidget);

    final Finder textParagraphFinder = find.byType(SliverFillRemaining);
    expect(textParagraphFinder, findsOneWidget);

    final Finder nextTextFinder = find.text ('Done');
    expect(nextTextFinder, findsOneWidget);

    final Finder nextButtonFinder = find.widgetWithText(ElevatedButton, 'Done');
    expect(nextButtonFinder, findsOneWidget);
  });
}