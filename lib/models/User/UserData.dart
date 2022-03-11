import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:age_calculator/age_calculator.dart';

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
  final DateTime? dob;
  final String? firstName, lastName;
  final String? gender;
  final String? university;
  final String? bio;
  final List<String>? interests;
  final GeoLocation? location;
  final Preferences? preferences;

  UserData(
      {this.dob, this.gender, this.university, this.bio, this.interests, this.location, this.preferences, this.firstName, this.lastName});

  factory UserData.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();
    return UserData(
      dob: (data?['dob'] as Timestamp).toDate(),
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      gender: data?['gender'],
      university: data?['university'],
      bio: data?['bio'],
      interests: List<String>.from(data?['interests']),
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
}
