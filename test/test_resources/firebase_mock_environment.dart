import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:project_seg/models/Matches/message.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/states/user_state.dart';

import 'testing_data.dart';

class FirebaseMockEnvironment {
  late final FirestoreService firestoreService;
  late final UserState userState;
  late final ContextState contextState;

  FirebaseMockEnvironment();

  Future<void> setup(String activeUserEmail, bool authenticated) async {
    firestoreService = await createFirestoreService();
    userState = await createUserState(activeUserEmail, authenticated);
    contextState = createContextState(firestoreService);
  }

  Future<UserState> createUserState(String activeUserEmail, bool authenticated) async {
    final doc = appUsersTestData.firstWhere((element) => element['email'] == activeUserEmail);

    final user = MockUser(
      uid: doc['uid'],
      email: doc['email'],
      isEmailVerified: doc['emailVerified'],
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

    await firestore.collection("app").doc("context").set(appContextTestData);

    for (Map doc in appContextInterestsTestData) {
      await firestore.collection("app").doc("context").collection("interests").doc(doc["id"]).set(doc["data"]);
    }

    for (Map doc in appUsersTestData) {
      if (doc['data'] != null) {
        final UserData userData = doc['data'] as UserData;
        await firestore.collection("users").doc(userData.uid).set(userData.toMap());
      }
    }

    for (Map doc in appUserMatchesTestData) {
      final match = doc['match'] as UserMatch;

      await firestore.collection("matches").doc(match.matchID).set({
        "uids": [doc['otherUserID'], match.match!.uid],
        "timestamp": match.timestamp,
      });

      if (match.messages != null) {
        for (Message message in match.messages!) {
          await firestore.collection("matches").doc(match.matchID).collection("messages").doc().set(message.toMap());
        }
      }
    }

    return FirestoreService(firebaseFirestore: firestore);
  }

  ContextState createContextState(FirestoreService firestoreService) {
    return ContextState(firestoreService: firestoreService);
  }
}
