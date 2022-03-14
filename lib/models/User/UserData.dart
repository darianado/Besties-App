import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:project_seg/models/category.dart';

class Preferences {
  final List<String> interests;
  final int maxAge;
  final int minAge;

  Preferences({required this.interests, required this.maxAge, required this.minAge});
}

class GeoLocation {
  final double lat, lon;

  GeoLocation({required this.lat, required this.lon});
}

class UserData {
  DateTime? dob;
  String? firstName, lastName;
  String? gender;
  String? university;
  String? bio;
  String? relationshipStatus;
  String? profileImageUrl;
  List<Category>? interests;
  GeoLocation? location;
  Preferences? preferences;

  UserData(
      {this.dob,
      this.gender,
      this.university,
      this.bio,
      this.relationshipStatus,
      this.interests,
      this.location,
      this.profileImageUrl,
      this.preferences,
      this.firstName,
      this.lastName});

  factory UserData.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();
    return UserData(
      dob: (data?['dob'] as Timestamp).toDate(),
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      gender: data?['gender'],
      university: data?['university'],
      bio: data?['bio'],
      relationshipStatus: data?['relationshipStatus'],
      profileImageUrl: data?['profileImageUrl'],
      interests: List<String>.from(data?['interests']).map((str) => Category(catId: str, title: str, interests: [])).toList(),
      location: GeoLocation(lat: data?['location']['lat'], lon: data?['location']['lon']),
      preferences: Preferences(
        interests: List<String>.from(data?['preferences']['interests']),
        maxAge: data?['preferences']['maxAge'],
        minAge: data?['preferences']['minAge'],
      ),
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
}
