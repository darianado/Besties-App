import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import '../../test_resources/helpers.dart';
import '../../test_resources/widget_pumper.dart';
import '../../test_resources/test_profile.dart';
import 'package:project_seg/screens/sign_up/register_photo_screen.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "markdoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group("Register photo screen:", () {
    testWidgets('Contains correct information', (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-photo", null);

      expect(find.byType(RegisterPhotoScreen), findsOneWidget);

      final Finder sliverAppBarFinder = find.byType(SliverAppBar);
      expect(sliverAppBarFinder, findsOneWidget);

      final Finder sliverAppBarLeadingButtonFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(IconButton));
      expect(sliverAppBarLeadingButtonFinder, findsOneWidget);
      final IconButton sliverAppBarLeadingButton = tester.widget<IconButton>(sliverAppBarLeadingButtonFinder);
      expect(sliverAppBarLeadingButton.onPressed, isNotNull);

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

    testWidgets('Tapping back button returns normally', (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-photo", null);

      expect(find.byType(RegisterPhotoScreen), findsOneWidget);

      final Finder sliverAppBarFinder = find.byType(SliverAppBar);
      expect(sliverAppBarFinder, findsOneWidget);

      final Finder sliverAppBarLeadingButtonFinder = find.descendant(of: sliverAppBarFinder, matching: find.byType(IconButton));
      expect(sliverAppBarLeadingButtonFinder, findsOneWidget);
      final IconButton sliverAppBarLeadingButton = tester.widget<IconButton>(sliverAppBarLeadingButtonFinder);
      expect(sliverAppBarLeadingButton.onPressed, isNotNull);
      expect(() => sliverAppBarLeadingButton.onPressed!(), returnsNormally);
    });

    testWidgets("Tapping photo returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-photo", null);

      expect(find.byType(RegisterPhotoScreen), findsOneWidget);

      final Finder imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
      final Finder inkWellFinder = find.ancestor(of: imageFinder, matching: find.byType(InkWell));
      expect(inkWellFinder, findsOneWidget);
      final InkWell inkWell = tester.widget<InkWell>(inkWellFinder);
      expect(inkWell.onTap, isNotNull);
      expect(() => inkWell.onTap!(), returnsNormally);
    });

    testWidgets("Tapping next button returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/register/register-photo", null);

      expect(find.byType(RegisterPhotoScreen), findsOneWidget);

      final Finder nextButtonFinder = find.widgetWithText(PillButtonFilled, 'Next');
      expect(nextButtonFinder, findsOneWidget);
      final PillButtonFilled nextButton = tester.widget<PillButtonFilled>(nextButtonFinder);
      expect(() => nextButton.onPressed(), returnsNormally);
    });
  });
}
