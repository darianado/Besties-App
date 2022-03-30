import 'package:flutter_test/flutter_test.dart';

import 'widget_pumper.dart';

Future<void> signOutHelper(WidgetPumper pumper) async {
  await pumper.firebaseEnv.userState.signOut();
  expect(pumper.firebaseEnv.userState.user?.user?.uid, isNull);
}

Future<void> signInHelper(WidgetPumper pumper, String email, String password) async {
  await pumper.firebaseEnv.userState.signIn(email, password);
  expect(pumper.firebaseEnv.userState.user?.user?.uid, isNotNull);
}
