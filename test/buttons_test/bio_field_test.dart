import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_textfield.dart';
import '../mock.dart';

import '../test_resources/TestProfile.dart';
import '../test_resources/WidgetPumper.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  OtherUser firstProfile = TestProfile.firstProfile;

  group('BioField Widget tests', () {
    testWidgets('Test BioField displays correct information', (tester) async {
      await WidgetPumper.pumpCustomWidget(
          tester, BioField(label: firstProfile.userData.bio!));

      expect(find.text(firstProfile.userData.bio!), findsOneWidget);
    });

    testWidgets(
        'Test editable BioField displays EditDialogTextField Widget on tap',
        (tester) async {
      await WidgetPumper.pumpCustomWidget(
          tester, BioField(label: firstProfile.userData.bio!, editable: true));

      expect(find.text(firstProfile.userData.bio!), findsOneWidget);

      await tester.tap(find.text(firstProfile.userData.bio!));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(EditDialogTextField), findsOneWidget);
      expect(find.text(firstProfile.userData.bio!), findsOneWidget);
    });
  });
}
