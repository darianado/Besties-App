import 'package:cloud_firestore/cloud_firestore.dart';

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
  final int age;
  final String firstName, lastName;
  final String gender;
  final List<String> interests;
  final GeoLocation location;
  final Preferences preferences;

  UserData(
      {required this.age,
      required this.gender,
      required this.interests,
      required this.location,
      required this.preferences,
      required this.firstName,
      required this.lastName});

  factory UserData.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();
    print("Initializing!");
    return UserData(
      age: data?['age'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      gender: data?['gender'],
      interests: data?['interests'],
      location: GeoLocation(lat: data?['location']['lat'], lon: data?['location']['lon']),
      preferences: Preferences(
        interests: data?['preferences']['interests'],
        maxAge: data?['preferences']['maxAge'],
        minAge: data?['preferences']['minAge'],
      ),
    );
  }
}
