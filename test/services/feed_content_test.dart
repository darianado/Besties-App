import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:project_seg/services/feed_content_gatherer.dart';

import '../test_resources/testing_data.dart';
import '../test_resources/widget_pumper.dart';

void main() {
  final WidgetPumper _widgetPumper = WidgetPumper();

  UserData johnUser = appUsersTestData[0]['data'] as UserData;
  UserData peterUser = appUsersTestData[1]['data'] as UserData;
  UserData janeUser = appUsersTestData[2]['data'] as UserData;

  setUpAll(() async {
    await _widgetPumper.setup("johndoe@example.org", authenticated: true);
  });

  group("Feed content controller:", () {
    testWidgets("Assigning controller returns normally", (tester) async {
      final fakePageController = PageController();
      await _widgetPumper.pumpWidget(tester, PageView(controller: fakePageController));

      final controller = FeedContentController(userState: _widgetPumper.firebaseEnv.userState);
      expect(() => controller.assignController(fakePageController), returnsNormally);

      expect(controller.gatherer.onLikeComplete, isNotNull);
      expect(() => controller.gatherer.onLikeComplete!(peterUser), returnsNormally);
    });

    testWidgets("Page listener returns normally for all controller states", (tester) async {
      final fakePageController = PageController();
      final controller = FeedContentController(userState: _widgetPumper.firebaseEnv.userState);

      controller.content.addAll(const [Text("1"), Text("2"), Text("3"), Text("4"), Text("5")]);

      await _widgetPumper.pumpWidget(
          tester,
          PageView(
            physics: const CustomPageViewScrollPhysics(),
            controller: fakePageController,
            children: controller.content,
          ));

      expect(() => controller.assignController(fakePageController), returnsNormally);

      /*
      await tester.idle();
      await tester.pump(const Duration(seconds: 2));
      */

      expect(controller.content, contains(isA<FeedLoadingSheet>()));

      fakePageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
      await tester.pumpAndSettle();

      fakePageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
      await tester.pumpAndSettle();

      fakePageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease);
      await tester.pumpAndSettle();
    });

    testWidgets("Moving FeedLoadingSheet to end returns normally", (tester) async {
      final fakePageController = PageController();
      final controller = FeedContentController(userState: _widgetPumper.firebaseEnv.userState);

      controller.content.addAll(const [Text("1"), Text("2"), Text("3"), Text("4"), Text("5")]);

      await _widgetPumper.pumpWidget(
          tester,
          PageView(
            physics: const CustomPageViewScrollPhysics(),
            controller: fakePageController,
            children: controller.content,
          ));

      expect(() => controller.assignController(fakePageController), returnsNormally);

      expect(controller.content, contains(isA<FeedLoadingSheet>()));
      expect(() => controller.moveLoadingScreenLast(), returnsNormally);
      expect(controller.content, contains(isA<FeedLoadingSheet>()));
    });
  });
}
