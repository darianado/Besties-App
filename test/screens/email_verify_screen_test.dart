import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/email_verify/email_verify_screen.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import '../FirebaseMockTestEnvironment.dart';
import '../mock.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  setUpAll(() async {
    await _widgetPumper.setup();
  });

  group("Email verify screen tests:", () {
    testWidgets('Test email verify screen displays correct information', (tester) async {
      await _widgetPumper.pumpWidget(tester, const EmailVerifyScreen());

      await tester.idle();
      await tester.pump();

      expect(find.textContaining("seg-djangoals@example.org"), findsOneWidget);
    });
  });
}
