import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/screens/home/feed/components/profile_container.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/models/User/other_user.dart';

import '../../../test_resources/firebase_mocks.dart';
import '../../../test_resources/test_profile.dart';
import '../../../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  const String userEmail = "johndoe@example.org";

  setUpAll(() async {
    await _widgetPumper.setup(userEmail, authenticated: true);
  });

  // group('Feed screen tests:', () {
  //   testWidgets('Contains correct information',
  //       (tester) async {
  //     await _widgetPumper.pumpWidget(tester, const FeedScreen());
  //
  //     await tester.idle();
  //     await tester.pump();
  //
  //     expect(find.text(), findsOneWidget);
  //
  //   });

  //});
}
