import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/models/User/user_data.dart';

final List<Map<String, dynamic>> appUsersTestData = [
  {
    "email": "johndoe@example.org",
    "emailVerified": true,
    "data": UserData(
      uid: "abc123",
      firstName: "John",
      lastName: "Doe",
      likes: [],
      bio: "Growth prevent power pull. Wind there role occur.",
      dob: DateTime(1999, 12, 19).toUtc(),
      gender: "Non-binary",
      university: "King's College London",
      relationshipStatus: "Single",
      profileImageUrl: "https://directemployers.org/wp-content/uploads/2018/08/avatar-JohnDoe.jpg",
      categorizedInterests: CategorizedInterests(
        categories: [
          Category(title: "Arts and Literature", interests: []),
          Category(title: "Food", interests: [
            Interest(title: "Cocktails"),
            Interest(title: "Brunch"),
            Interest(title: "Vegan"),
            Interest(title: "Baking"),
          ]),
          Category(title: "Games", interests: []),
          Category(title: "Popular culture", interests: []),
          Category(title: "Science and Technology", interests: []),
          Category(title: "Self care", interests: []),
          Category(title: "Social activities", interests: []),
          Category(title: "Sports", interests: []),
        ],
      ),
      preferences: Preferences(
        maxAge: 50,
        minAge: 18,
        genders: ["Non-binary", "Female"],
        interests: CategorizedInterests(
          categories: [
            Category(title: "Arts and Literature", interests: [
              Interest(title: "Musicals"),
              Interest(title: "Theatre"),
              Interest(title: "Classical music"),
              Interest(title: "Novels"),
            ]),
            Category(title: "Food", interests: [
              Interest(title: "Cocktails"),
              Interest(title: "Vegan"),
              Interest(title: "Baking"),
            ]),
            Category(title: "Games", interests: []),
            Category(title: "Popular culture", interests: [
              Interest(title: "Stand-up comedy"),
            ]),
            Category(title: "Science and Technology", interests: [
              Interest(title: "Medicine"),
            ]),
            Category(title: "Self care", interests: []),
            Category(title: "Social activities", interests: []),
            Category(title: "Sports", interests: []),
          ],
        ),
      ),
    ),
  },
  {
    "email": "janedoe@example.org",
    "emailVerified": false,
    "data": UserData(
      uid: "very-random-id",
      firstName: "Jane",
      lastName: "Doe",
      likes: [],
      bio: "Growth prevent power pull. Wind there role occur.",
      dob: DateTime(1999, 12, 19).toUtc(),
      gender: "Non-binary",
      university: "King's College London",
      relationshipStatus: "Single",
      profileImageUrl: "https://directemployers.org/wp-content/uploads/2018/08/avatar-JohnDoe.jpg",
      categorizedInterests: CategorizedInterests(
        categories: [
          Category(title: "Arts and Literature", interests: []),
          Category(title: "Food", interests: [
            Interest(title: "Cocktails"),
            Interest(title: "Brunch"),
            Interest(title: "Vegan"),
            Interest(title: "Baking"),
          ]),
          Category(title: "Games", interests: []),
          Category(title: "Popular culture", interests: []),
          Category(title: "Science and Technology", interests: []),
          Category(title: "Self care", interests: []),
          Category(title: "Social activities", interests: []),
          Category(title: "Sports", interests: []),
        ],
      ),
      preferences: Preferences(
        maxAge: 50,
        minAge: 18,
        genders: ["Non-binary", "Female"],
        interests: CategorizedInterests(
          categories: [
            Category(title: "Arts and Literature", interests: [
              Interest(title: "Musicals"),
              Interest(title: "Theatre"),
              Interest(title: "Classical music"),
              Interest(title: "Novels"),
            ]),
            Category(title: "Food", interests: [
              Interest(title: "Cocktails"),
              Interest(title: "Vegan"),
              Interest(title: "Baking"),
            ]),
            Category(title: "Games", interests: []),
            Category(title: "Popular culture", interests: [
              Interest(title: "Stand-up comedy"),
            ]),
            Category(title: "Science and Technology", interests: [
              Interest(title: "Medicine"),
            ]),
            Category(title: "Self care", interests: []),
            Category(title: "Social activities", interests: []),
            Category(title: "Sports", interests: []),
          ],
        ),
      ),
    ),
  },
];

final appContextTestData = {
  "genders": [
    "Male",
    "Female",
    "Non-binary",
  ],
  "maxAge": 50,
  "minAge": 16,
  "maxBioLength": 250,
  "maxChatMessageLength": 500,
  "maxInterestsSelected": 10,
  "minInterestsSelected": 1,
  "relationshipStatuses": [
    "Single",
    "In a relationship",
    "It's complicated",
    "Engaged",
    "Married",
  ],
  "universities": [
    "Birkbeck, University of London",
    "Brunel University London",
    "City, University of London",
    "King's College London",
  ],
};

final appContextInterestsTestData = [
  {
    "id": "artsAndLiterature",
    "data": {
      "interests": [
        "Jazz",
        "Classical music",
        "Musicals",
      ],
      "title": "Arts and Literature",
    },
  },
  {
    "id": "food",
    "data": {
      "interests": [
        "Cocktails",
        "Brunch",
        "Coffee",
      ],
      "title": "Food",
    },
  },
  {
    "id": "games",
    "data": {
      "interests": [
        "Video games",
        "Card games",
        "Board games",
      ],
      "title": "Games",
    },
  }
];
