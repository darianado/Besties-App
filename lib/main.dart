import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/router/routes.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:project_seg/services/feed_content_gatherer.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestoreService = FirestoreService(firebaseFirestore: FirebaseFirestore.instance);
  final userState = UserState(
    authService: AuthService(firebaseAuth: FirebaseAuth.instance),
    firestoreService: firestoreService,
  );
  final appRouter = AppRouter(userState);
  final contextState = ContextState(firestoreService: firestoreService);
  final feedContentController = FeedContentController(userState: userState, gatherer: FeedContentGatherer(userState: userState));
  final matchState = MatchState(firestoreService: firestoreService);

  runApp(MyApp(
    userState: userState,
    appRouter: appRouter,
    contextState: contextState,
    feedContentController: feedContentController,
    matchState: matchState,
    firestoreService: firestoreService,
  ));
}

class MyApp extends StatelessWidget {
  final UserState userState;
  final AppRouter appRouter;
  final ContextState contextState;
  final FeedContentController feedContentController;
  final MatchState matchState;
  final FirestoreService firestoreService;

  const MyApp({
    Key? key,
    required this.userState,
    required this.appRouter,
    required this.contextState,
    required this.feedContentController,
    required this.matchState,
    required this.firestoreService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(
          lazy: false,
          create: (context) => userState,
        ),
        Provider<AppRouter>(
          lazy: false,
          create: (context) => appRouter,
        ),
        ChangeNotifierProvider<ContextState>(
          lazy: false,
          create: (context) => contextState,
        ),
        ChangeNotifierProvider<FeedContentController>(
          lazy: false,
          create: (context) => feedContentController,
        ),
        ChangeNotifierProvider<MatchState>(
          lazy: false,
          create: (context) => matchState,
        ),
        Provider<FirestoreService>(
          lazy: false,
          create: (context) => firestoreService,
        ),
      ],
      child: Builder(
        builder: (context) {
          final router = Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.nunitoTextTheme(
                (Theme.of(context).textTheme).apply(
                  bodyColor: tertiaryColour,
                  displayColor: tertiaryColour,
                ),
              ),
            ),
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        },
      ),
    );
  }
}
