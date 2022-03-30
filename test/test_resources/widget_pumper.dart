import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/router/routes.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'firebase_mock_environment.dart';

class WidgetPumper {
  final FirebaseMockEnvironment firebaseEnv = FirebaseMockEnvironment();

  WidgetPumper();

  Future<void> setup(String activeUserEmail, {bool authenticated = false}) => firebaseEnv.setup(activeUserEmail, authenticated);

  Future<void> pumpWidget(WidgetTester tester, Widget widget) async {
    return await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: firebaseEnv.userState),
          ChangeNotifierProvider<ContextState>.value(value: firebaseEnv.contextState),
          Provider<FirestoreService>.value(value: firebaseEnv.firestoreService),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: widget,
          ),
        ),
      ),
    );
  }

  Future<void> pumpWidgetRouter(WidgetTester tester, String location) async {
    final appRouter = AppRouter(firebaseEnv.userState);
    return await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: firebaseEnv.userState),
          ChangeNotifierProvider<ContextState>.value(value: firebaseEnv.contextState),
          Provider<FirestoreService>.value(value: firebaseEnv.firestoreService),
          Provider<AppRouter>.value(value: appRouter),
        ],
        child: MaterialApp.router(
          routeInformationParser: appRouter.router(location).routeInformationParser,
          routerDelegate: appRouter.router(location).routerDelegate,
        ),
      ),
    );
  }
}
