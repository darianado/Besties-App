import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/components/dialogs/delete_account_dialog.dart';
import 'package:project_seg/screens/home/profile/edit_profile_screen.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';

import '../../../test_resources/helpers.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  group('Edit profile screen:', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidgetRouter(tester, "/profile/edit-profile", null);

      expect(find.byType(EditProfileScreen), findsOneWidget);

      final Finder profileInformationFinder = find.byType(ProfileInformation);
      expect(profileInformationFinder, findsOneWidget);
      final ProfileInformation profileInformation = tester.widget<ProfileInformation>(profileInformationFinder);

      expect(_widgetPumper.firebaseEnv.userState.user?.userData, profileInformation.userData);

      expect(find.textContaining("John"), findsOneWidget);
      expect(find.textContaining("Doe"), findsOneWidget);
    });

    testWidgets("Clicking delete account returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/profile/edit-profile", null);

      expect(find.byType(EditProfileScreen), findsOneWidget);

      final Finder deleteAccountButtonFinder = find.widgetWithText(PillButtonOutlined, "Delete account");
      expect(deleteAccountButtonFinder, findsOneWidget);

      final PillButtonOutlined deleteAccountButton = tester.widget<PillButtonOutlined>(deleteAccountButtonFinder);

      expect(() => deleteAccountButton.onPressed(), returnsNormally);

      await tester.pump(const Duration(seconds: 2));

      expect(find.byType(DeleteAccountDialog), findsOneWidget);
    });

    testWidgets("Clicking done returns normally", (tester) async {
      await signInHelper(_widgetPumper, userEmail);
      await _widgetPumper.pumpWidgetRouter(tester, "/profile/edit-profile", null);

      expect(find.byType(EditProfileScreen), findsOneWidget);

      final Finder doneButtonFinder = find.byType(RoundActionButton);
      expect(doneButtonFinder, findsOneWidget);
      final RoundActionButton doneButton = tester.widget<RoundActionButton>(doneButtonFinder);
      expect(doneButton.onPressed, isNotNull);
      expect(() => doneButton.onPressed!(), returnsNormally);
    });
  });
}
