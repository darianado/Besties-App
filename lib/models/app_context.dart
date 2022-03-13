import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/gender_implementation.dart';
import 'package:project_seg/services/firestore_service.dart';

class AppContext {
  List<String>? universities;
  List<String>? genders;
  List<String>? relationshipStatuses;
  int? maxBioLength;

  AppContext({
    this.universities,
    this.genders,
    this.relationshipStatuses,
    this.maxBioLength,
  });

  factory AppContext.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();

    List<String> universities = List<String>.from(data?['universities']);
    universities.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    return AppContext(
      universities: universities,
      genders: List<String>.from(data?['genders']),
      relationshipStatuses: List<String>.from(data?['relationshipStatuses']),
      maxBioLength: data?['maxBioLength'],
    );
  }
}
