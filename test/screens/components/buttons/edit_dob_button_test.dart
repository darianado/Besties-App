import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import '../../../test_resources/firebase_mocks.dart';

import '../../../test_resources/test_profile.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  UserData testUser = appUsersTestData[0]['data'] as UserData;

  group('Date of Birth button widget:', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, DateOfBirthButton(label: testUser.age!.toString(), editable: true));

      expect(find.text(testUser.age!.toString()), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.birthdayCake), findsOneWidget);

      final Finder chipFinder = find.byType(ChipWidget);
      expect(chipFinder, findsOneWidget);
      final ChipWidget chipWidget = tester.widget<ChipWidget>(chipFinder);
      expect(chipWidget.onTap, isNotNull);
    });

    testWidgets('Can wiggle', (tester) async {
      await _widgetPumper.pumpWidget(tester, DateOfBirthButton(label: testUser.age!.toString(), editable: true, wiggling: true));

      expect(find.text(testUser.age!.toString()), findsOneWidget);
      expect(find.byIcon(FontAwesomeIcons.birthdayCake), findsOneWidget);

      final Finder chipFinder = find.byType(ChipWidget);
      expect(chipFinder, findsOneWidget);
      final ChipWidget chipWidget = tester.widget<ChipWidget>(chipFinder);
      expect(chipWidget.onTap, isNotNull);

      final Finder shakeAnimationFinder = find.byType(ShakeAnimatedWidget);
      expect(shakeAnimationFinder, findsOneWidget);
      final ShakeAnimatedWidget shakeAnimatedWidget = tester.widget<ShakeAnimatedWidget>(shakeAnimationFinder);
      expect(shakeAnimatedWidget.shakeAngle, Rotation.deg(z: 1.5));
      expect(shakeAnimatedWidget.child, isA<ChipWidget>());
    });

    testWidgets('Tapping opens date picker', (tester) async {
      await _widgetPumper.pumpWidget(tester, DateOfBirthButton(label: testUser.age!.toString(), editable: true));

      final Finder chipFinder = find.byType(ChipWidget);
      expect(chipFinder, findsOneWidget);
      final ChipWidget chipWidget = tester.widget<ChipWidget>(chipFinder);
      expect(() => chipWidget.onTap!(), returnsNormally);
    });
  });
}
