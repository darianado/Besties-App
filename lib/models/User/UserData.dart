import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:project_seg/models/category.dart';
import 'package:project_seg/models/interest.dart';

class Preferences {
  final List<String> interests;
  final int maxAge;
  final int minAge;

  Preferences({required this.interests, required this.maxAge, required this.minAge});

  Map toMap() {
    return {
      "interests": interests,
      "maxAge": maxAge,
      "minAge": minAge,
    };
  }
}

class GeoLocation {
  final double lat, lon;

  GeoLocation({required this.lat, required this.lon});

  Map toMap() {
    return {
      "lat": lat,
      "lon": lon,
    };
  }
}

class UserData {
  DateTime? dob;
  String? firstName, lastName;
  String? gender;
  String? university;
  String? bio;
  String? relationshipStatus;
  String? profileImageUrl;
  List<Category>? categorizedInterests;
  GeoLocation? location;
  Preferences? preferences;

  UserData(
      {this.dob,
      this.gender,
      this.university,
      this.bio,
      this.relationshipStatus,
      this.categorizedInterests,
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
      categorizedInterests: List<String>.from(data?['interests']).map((str) => Category(catId: str, title: str, interests: [])).toList(),
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

  List<Interest>? get flattenedInterests {
    return categorizedInterests
        ?.map((category) => category.interests.where((interest) => interest.selected).toList())
        .expand((i) => i)
        .toList();
  }

  Map toMap() {
    return {
      "dob": dob,
      "firstName": firstName,
      "lastName": lastName,
      "university": university,
      "gender": gender,
      "relationshipStatus": relationshipStatus,
      "bio": bio,
      "profileImageUrl": profileImageUrl,
      "categorizedInterests": flattenedInterests?.map((e) => e.title).toList(),
      "location": location?.toMap(),
      "preferences": preferences?.toMap()
    };
  }
}
