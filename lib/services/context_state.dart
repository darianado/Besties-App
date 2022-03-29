import 'package:flutter/material.dart';
import 'package:project_seg/models/App/app_context.dart';
import 'package:project_seg/services/firestore_service.dart';

class ContextState extends ChangeNotifier {
  final FirestoreService firestoreService;

  AppContext? context;

  ContextState({required this.firestoreService}) {
    onAppStart();
  }

  void onAppStart() {
    firestoreService.appContext().listen((AppContext contextSnapshot) {
      context = contextSnapshot;
      notifyListeners();
    });
  }
}
