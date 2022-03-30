import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';

abstract class TestProfile {
  static OtherUser firstProfile = OtherUser(
    userData: UserData(
      firstName: "Amy",
      lastName: "Garcia",
      university: "King's College London",
      relationshipStatus: "In a relationship",
      gender: "Female",
      bio: "This is my bio.",
      dob: DateTime(2001, 1, 1),
      categorizedInterests: CategorizedInterests(
        categories: [
          Category(
            title: "food",
            interests: [
              Interest(title: "Cocktails"),
              Interest(title: "Brunch"),
              Interest(title: "Coffee"),
            ],
          ),
          Category(
            title: "sports",
            interests: [
              Interest(title: "Hiking"),
              Interest(title: "Swimming"),
            ],
          )
        ],
      ),
    ),
    liked: false,
  );
}
