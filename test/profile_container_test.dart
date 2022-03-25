import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project_seg/models/User/OtherUser.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/profile_container.dart';
import 'package:project_seg/router/routes.dart';
import 'package:project_seg/dalu_auth/mock.dart';
import 'package:project_seg/screens/components/sliding_profile_details.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:network_image_mock/network_image_mock.dart';

// Widget createProfileContainer(profile) => ;
Widget createProfileContainer(profile) => MediaQuery(
      data: const MediaQueryData(),
      child: MaterialApp(
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<UserState>(
              lazy: false,
              create: (BuildContext context) => UserState.instance,
            ),
            Provider<AppRouter>(
              lazy: false,
              create: (BuildContext context) => AppRouter(UserState.instance),
            ),
            ChangeNotifierProvider<ContextState>(
              lazy: false,
              create: (BuildContext context) => ContextState.instance,
            ),
            ChangeNotifierProvider<FeedContentController>(
              lazy: false,
              create: (context) => FeedContentController.instance,
            ),
          ],
          child: Builder(
            builder: (_) =>
                ProfileContainer(profile: profile, onLikeComplete: () => {}),
          ),
        ),
      ),
    );

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  OtherUser firstProfile = OtherUser(
      userData: UserData(
          firstName: "Amy",
          lastName: "Garcia",
          university: "King's College London",
          relationshipStatus: "In a relationship",
          bio: "This is my bio."),
      liked: false);

  group('Feed Page widget tests', () {
    testWidgets('Test profile container displays correct information',
        (tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(createProfileContainer(firstProfile));
        await tester.pump();
        expect(find.text(firstProfile.userData.firstName!), findsOneWidget);
        expect(find.text(firstProfile.userData.university!), findsOneWidget);

        expect(find.text(firstProfile.userData.lastName!), findsNothing);
        expect(
            find.text(firstProfile.userData.relationshipStatus!), findsNothing);
        expect(find.text(firstProfile.userData.bio!), findsNothing);

        await tester.tap(find.text(firstProfile.userData.university!));
        await tester.pumpAndSettle();

        expect(find.text(firstProfile.userData.firstName!), findsOneWidget);
        // expect(find.text(firstProfile.userData.lastName!), findsOneWidget);
        expect(find.text(firstProfile.userData.university!), findsOneWidget);
        expect(find.text(firstProfile.userData.relationshipStatus!),
            findsOneWidget);
        expect(find.text(firstProfile.userData.bio!), findsOneWidget);
      });
    });
  });
}
