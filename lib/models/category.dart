import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/models/interest.dart';

class Category {
  String catId;
  String title;
  List<Interest> interests;

  Category({required this.catId, required this.title, required this.interests});

  factory Category.fromSnapshot(DocumentSnapshot<Map> snapshot) {
    Map? data = snapshot.data();

    List<Interest> interests = List<String>.from(data?['entries']).map((str) => Interest(title: str)).toList();

    return Category(
      catId: snapshot.id,
      title: data?['title'],
      interests: interests,
    );
  }
}
