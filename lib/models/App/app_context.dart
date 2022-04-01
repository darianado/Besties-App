import 'package:cloud_firestore/cloud_firestore.dart';

/// This class  stores content that is available throughout the app.
class AppContext {
  List<String>? universities;
  List<String>? genders;
  List<String>? relationshipStatuses;
  int? maxBioLength;
  int? maxChatMessageLength;
  int? minInterestsSelected;
  int? maxInterestsSelected;
  int? minAge;
  int? maxAge;

  AppContext({
    this.universities,
    this.genders,
    this.relationshipStatuses,
    this.maxBioLength,
    this.maxChatMessageLength,
    this.minInterestsSelected,
    this.maxInterestsSelected,
    this.minAge,
    this.maxAge,
  });

  /// This factory creates an instance of [AppContext] from a [DocumentSnapshot].
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
      maxChatMessageLength: data?['maxChatMessageLength'],
      maxInterestsSelected: data?['maxInterestsSelected'],
      minInterestsSelected: data?['minInterestsSelected'],
      maxAge: data?['maxAge'],
      minAge: data?['minAge'],
    );
  }
}
