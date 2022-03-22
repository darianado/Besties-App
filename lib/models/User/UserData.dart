import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';

class CategorizedInterests {
  final List<Category> categories;

  CategorizedInterests({required this.categories});

  factory CategorizedInterests.fromList(List<dynamic> list) {
    final categories = list.map((e) => Category.fromMap(e)).toList();
    return CategorizedInterests(categories: categories);
  }

  List<Map<String, dynamic>> toList() {
    return categories.map((e) => e.toMap()).toList();
  }
}

class Preferences {
  final CategorizedInterests interests;
  final int maxAge;
  final int minAge;

  Preferences({required this.interests, required this.maxAge, required this.minAge});

  factory Preferences.fromMap(Map<String, dynamic> map) {
    final _interests = CategorizedInterests.fromList(map['categorizedInterests']);
    return Preferences(interests: _interests, maxAge: map['maxAge'], minAge: map['minAge']);
  }

  Map<String, dynamic> toMap() {
    return {
      "categorizedInterests": interests.toList(),
      "maxAge": maxAge,
      "minAge": minAge,
    };
  }
}

class GeoLocation {
  final double lat, lon;

  GeoLocation({required this.lat, required this.lon});

  factory GeoLocation.fromMap(Map<String, dynamic> map) {
    return GeoLocation(lat: map['lat'], lon: map['lon']);
  }

  Map<String, dynamic> toMap() {
    return {
      "lat": lat,
      "lon": lon,
    };
  }
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
  GeoLocation? location;
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

    final _categorizedInterests = CategorizedInterests.fromList(data?['categorizedInterests']);

    return UserData(
      uid: doc.id,
      dob: (data?['dob'] as Timestamp).toDate(),
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      gender: data?['gender'],
      //likes: List<String>.from(data?['likes']),
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

  List<Interest>? get flattenedInterests {
    return categorizedInterests?.categories.map((category) => category.interests).expand((i) => i).toList();
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
      "location": location?.toMap(),
      "preferences": preferences?.toMap(),
      "likes": likes,
    };
  }
}
