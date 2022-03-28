import 'package:age_calculator/age_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';

class Preferences {
  CategorizedInterests? interests;
  List<String?>? genders;
  int? maxAge;
  int? minAge;

  Preferences({
    this.interests,
    this.maxAge,
    this.minAge,
    this.genders,
  });

  factory Preferences.fromMap(Map<String, dynamic> map) {
    final _interests = CategorizedInterests.fromList(map['categorizedInterests'] ?? []);
    return Preferences(
      interests: _interests,
      genders: List<String?>.from(map['genders'] ?? []),
      maxAge: map['maxAge'],
      minAge: map['minAge'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "categorizedInterests": interests?.toList(),
      "genders": genders,
      "maxAge": maxAge,
      "minAge": minAge,
    };
  }

  @override
  bool operator ==(other) {
    return other is Preferences &&
        maxAge == other.maxAge &&
        minAge == other.minAge &&
        (genders?.every((element) => other.genders?.contains(element) ?? false) ?? false) &&
        interests == other.interests;
  }

  @override
  int get hashCode =>
      super.hashCode ^ (maxAge != null ? maxAge! : 1) ^ (minAge != null ? minAge! : 1) ^ (genders != null ? genders!.length : 1);
}

class UserData {
  String? uid;
  DateTime? dob;
  String? firstName, lastName;
  String? gender;
  String? university;
  String? bio;
  String? relationshipStatus;
  String? profileImageUrl;
  CategorizedInterests? categorizedInterests;
  Preferences? preferences;
  List<String>? likes;

  UserData(
      {this.uid,
      this.dob,
      this.gender,
      this.university,
      this.bio,
      this.relationshipStatus,
      this.categorizedInterests,
      this.profileImageUrl,
      this.preferences,
      this.firstName,
      this.lastName,
      this.likes});

  factory UserData.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();

    final _categorizedInterests = CategorizedInterests.fromList(data?['categorizedInterests'] ?? []);

    return UserData(
      uid: doc.id,
      dob: (data?['dob'] as Timestamp).toDate(),
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      gender: data?['gender'],
      likes: List<String>.from(data?['likes'] ?? []),
      university: data?['university'],
      bio: data?['bio'],
      relationshipStatus: data?['relationshipStatus'],
      profileImageUrl: data?['profileImageUrl'],
      categorizedInterests: _categorizedInterests,
      preferences: Preferences.fromMap(data?['preferences']),
    );
  }

  String? get fullName {
    return (firstName ?? "") + (firstName != null ? " " : "") + (lastName ?? "");
  }

  int? get age {
    DateTime? localDob = dob;
    if (localDob != null) {
      return AgeCalculator.age(localDob).years;
    } else {
      return null;
    }
  }

  String? get humanReadableDateOfBirth {
    int? year = dob?.year;
    int? month = dob?.month;
    int? day = dob?.day;

    if (year != null && month != null && day != null) {
      return "$day-$month-$year";
    }

    return null;
  }

  Map<String, dynamic> toMap() {
    return {
      "dob": dob,
      "firstName": firstName,
      "lastName": lastName,
      "university": university,
      "gender": gender,
      "relationshipStatus": relationshipStatus,
      "bio": bio,
      "profileImageUrl": profileImageUrl,
      "categorizedInterests": categorizedInterests?.toList(),
      "preferences": preferences?.toMap(),
      "likes": likes,
    };
  }
}
