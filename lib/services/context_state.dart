import 'package:flutter/material.dart';
import 'package:project_seg/models/app_context.dart';
import 'package:project_seg/services/firestore_service.dart';

class ContextState extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService.instance;

  AppContext? context;

  ContextState._privateConstructor();
  static final ContextState _instance = ContextState._privateConstructor();
  static ContextState get instance => _instance;

  void onAppStart() {
    _firestoreService.appContext().listen((AppContext contextSnapshot) {
      context = contextSnapshot;
      notifyListeners();
    });
  }
}
