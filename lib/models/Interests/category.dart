import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/Interests/interest.dart';

class Category {
  String title;
  List<Interest> interests;

  Category({required this.title, required this.interests});

  factory Category.fromSnapshot(DocumentSnapshot<Map> snapshot) {
    Map? data = snapshot.data();

    List<Interest> interests = List<String>.from(data?['interests']).map((str) => Interest(title: str)).toList();

    return Category(
      title: data?['title'],
      interests: interests,
    );
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    final _interests = List<String>.from(map['interests']).map((e) => Interest(title: e)).toList();
    return Category(title: map['title'], interests: _interests);
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "interests": interests.map((e) => e.title).toList(),
    };
  }
}
