import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../FirebaseMockTestEnvironment.dart';

class WidgetPumper {
  final FirebaseMockTestEnvironment _firebaseEnv = FirebaseMockTestEnvironment();

  WidgetPumper();

  Future<void> setup() => _firebaseEnv.setup();

  Future<void> pumpWidget(WidgetTester tester, Widget widget) async {
    return await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: _firebaseEnv.userState),
          ChangeNotifierProvider<ContextState>.value(value: _firebaseEnv.contextState),
          Provider<FirestoreService>.value(value: _firebaseEnv.firestoreService),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }
}

/*

/// Holds static methods to pump widgets for testing purposes.
abstract class WidgetPumper {
  /// Pumps a [Widget] wrapped in the required [ChangeNotifierProvider].
  static pumpCustomWidget(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<UserState>.value(
        value: UserState(
            authService: AuthService(firebaseAuth: FirebaseAuth.instance),
            firestoreService: FirestoreService(firebaseFirestore: FirebaseFirestore.instance)),
        child: ChangeNotifierProvider<ContextState>.value(
          value: ContextState(firestoreService: FirestoreService(firebaseFirestore: FirebaseFirestore.instance)),
          child: MaterialApp(
            home: Scaffold(
              body: widget,
            ),
          ),
        ),
      ),
    );
  }

  /// Pumps a [Widget] wrapped in the required [ChangeNotifierProvider].
  static pumpCustomWidgetWithProviders(WidgetTester tester, Widget widget, List<SingleChildWidget> providers) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: providers,
        child: MaterialApp(
          home: Scaffold(body: widget),
        ),
      ),
    );
  }
}*/
