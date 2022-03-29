import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/states/user_state.dart';

class FirebaseMockTestEnvironment {
  late final FirestoreService firestoreService;
  late final UserState userState;
  late final ContextState contextState;

  FirebaseMockTestEnvironment();

  Future<void> setup() async {
    firestoreService = await createFirestoreService();
    userState = await createUserState(authenticated: true);
    contextState = createContextState(firestoreService);
  }

  Future<UserState> createUserState({bool authenticated = true}) async {
    final user = MockUser(
      email: "seg-djangoals@example.org",
      isEmailVerified: false,
    );

    final auth = MockFirebaseAuth(mockUser: user);
    final authService = AuthService(firebaseAuth: auth);
    final _userState = UserState(authService: authService, firestoreService: firestoreService);
    if (authenticated) {
      await auth.signInWithCredential(null);
    }

    return _userState;
  }

  Future<FirestoreService> createFirestoreService() async {
    final firestore = FakeFirebaseFirestore();

    await firestore.collection("app").doc("context").set({
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
    });

    await firestore.collection("app").doc("context").collection("interests").doc("artsAndLiterature").set({
      "interests": [
        "Jazz",
        "Classical music",
        "Musicals",
      ],
      "title": "Arts and Literature",
    });

    await firestore.collection("app").doc("context").collection("interests").doc("food").set({
      "interests": [
        "Cocktails",
        "Brunch",
        "Coffee",
      ],
      "title": "Food",
    });

    await firestore.collection("app").doc("context").collection("interests").doc("games").set({
      "interests": [
        "Video games",
        "Card games",
        "Board games",
      ],
      "title": "Games",
    });

    return FirestoreService(firebaseFirestore: firestore);
  }

  ContextState createContextState(FirestoreService firestoreService) {
    return ContextState(firestoreService: firestoreService);
  }
}
