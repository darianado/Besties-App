import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_textfield.dart';
import '../../../test_resources/firebase_mocks.dart';

import '../../../test_resources/test_profile.dart';
import '../../../test_resources/testing_data.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData testUser = appUsersTestData[0]['data'] as UserData;

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group('Bio field widget:', () {
    testWidgets('Displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, BioField(label: testUser.bio!));

      expect(find.text(testUser.bio!), findsOneWidget);
    });

    testWidgets('Displays EditDialogTextField widget on tap', (tester) async {
      await _widgetPumper.pumpWidget(tester, BioField(label: testUser.bio!, editable: true));

      expect(find.text(testUser.bio!), findsOneWidget);

      await tester.tap(find.text(testUser.bio!));
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(EditDialogTextField), findsOneWidget);
    });

    testWidgets("Saving a new bio returns normally", (tester) async {
      await _widgetPumper.pumpWidget(tester, BioField(label: testUser.bio!, editable: true));

      expect(find.text(testUser.bio!), findsOneWidget);

      await tester.tap(find.text(testUser.bio!));
      await tester.pump(const Duration(milliseconds: 500));

      final Finder editDialogTextFieldFinder = find.byType(EditDialogTextField);
      expect(editDialogTextFieldFinder, findsOneWidget);
      final EditDialogTextField dialog = tester.widget<EditDialogTextField>(editDialogTextFieldFinder);

      expect(() => dialog.onSave(testUser.uid, "This is a new bio"), returnsNormally);
    });
  });
}
