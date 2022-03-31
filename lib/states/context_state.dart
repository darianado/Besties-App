import 'package:flutter/material.dart';
import 'package:project_seg/models/App/app_context.dart';
import 'package:project_seg/services/firestore_service.dart';

/// A [ChangeNotifier] which listens for the app context.
///
/// 'app context' includes application-wide information such as
/// maximum bio length, minimum number of interests that can be selected, etc.
///
/// This class should be served using a [ChangeNotifierProvider] to all widgets
/// that need access to information about the context in which the application
/// is working.
class ContextState extends ChangeNotifier {
  final FirestoreService firestoreService;

  AppContext? context;

  /// Constructor for the ContextState class. Starts listeners upon
  /// construction, and may call [notifyListeners] immediately hereafter.
  ContextState({required this.firestoreService}) {
    onAppStart();
  }

  /// Main method responsible for creating and manipulating
  /// the [AppContext], as well as calling [notifyListeners].
  void onAppStart() {
    firestoreService.appContext().listen((AppContext contextSnapshot) {
      context = contextSnapshot;
      notifyListeners();
    });
  }
}
