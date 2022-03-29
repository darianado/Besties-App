
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

/// Holds static methods to pump widgets for testing purposes.
abstract class WidgetPumper {
  /// Pumps a [Widget] wrapped in the required [ChangeNotifierProvider].
  static pumpCustomWidget(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      Builder(
        builder: (BuildContext context) {
          return ChangeNotifierProvider<UserState>.value(
            value: UserState.instance,
            child: ChangeNotifierProvider<ContextState>.value(
              value: ContextState.instance,
              child: MaterialApp(
                home: Scaffold(
                  body: widget,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
