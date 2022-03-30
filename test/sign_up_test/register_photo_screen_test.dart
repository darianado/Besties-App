import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import '../test_resources/widget_pumper.dart';
import '../test_resources/test_profile.dart';
import 'package:project_seg/screens/sign_up/register_photo_screen.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';




void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "janedoe@example.org";

  UserData currentUserData = UserData();


  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

    testWidgets('Register Screen Contains correct information', (tester) async {
       await _widgetPumper.pumpWidget(tester, RegisterPhotoScreen(userData: currentUserData));

      final Finder photoIcon = find.byIcon(Icons.arrow_back_ios);
      expect(photoIcon, findsOneWidget);
      final Icon photoIconStyle = tester.widget<Icon>(photoIcon);
      expect(photoIconStyle.color, primaryColour);

      final Finder textFinder = find.text('Great! Now a photo...');
      expect(textFinder, findsOneWidget);

      final Text textStyle = tester.widget<Text>(textFinder);
      expect(textStyle.style?.color, secondaryColour);

      final Finder image = find.byType(Image);
      expect(image, findsOneWidget);

      final Finder editText = find.text("EDIT");
      expect(editText, findsOneWidget);
      final Text editTextStyle = tester.widget<Text>(editText);
      expect(editTextStyle.style!.color, whiteColour);

      final Finder nextButton = find.widgetWithText(PillButtonFilled, 'Next');
      expect(nextButton, findsOneWidget);

      final nextButtonStyle = tester.widget<PillButtonFilled>(nextButton);
      expect(nextButtonStyle.text, 'Next');
      expect(nextButtonStyle.textStyle!.fontSize, 25);
      expect(nextButtonStyle.textStyle!.fontWeight, FontWeight.w600);
    
    });

    testWidgets('Register Screen display actual image', (tester) async {

      OtherUser userWithImage = TestProfile.firstProfile;

      UserData currentUserData = UserData(profileImageUrl: userWithImage.userData.profileImageUrl);


       await _widgetPumper.pumpWidget(tester, RegisterPhotoScreen(userData: currentUserData));

      final Finder photoIcon = find.byIcon(Icons.arrow_back_ios);
      expect(photoIcon, findsOneWidget);
      final Icon photoIconStyle = tester.widget<Icon>(photoIcon);
      expect(photoIconStyle.color, primaryColour);

      final Finder textFinder = find.text('Great! Now a photo...');
      expect(textFinder, findsOneWidget);

      final Text textStyle = tester.widget<Text>(textFinder);
      expect(textStyle.style?.color, secondaryColour);

      final Finder image = find.byType(CachedImage);
      expect(image, findsOneWidget);

      final Finder editText = find.text("EDIT");
      expect(editText, findsOneWidget);
      final Text editTextStyle = tester.widget<Text>(editText);
      expect(editTextStyle.style!.color, whiteColour);

      final Finder nextButton = find.widgetWithText(PillButtonFilled, 'Next');
      expect(nextButton, findsOneWidget);

      final nextButtonStyle = tester.widget<PillButtonFilled>(nextButton);
      expect(nextButtonStyle.text, 'Next');
      expect(nextButtonStyle.textStyle!.fontSize, 25);
      expect(nextButtonStyle.textStyle!.fontWeight, FontWeight.w600);
    
    });
  
}