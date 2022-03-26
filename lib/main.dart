import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/App/app_context.dart';
import 'package:project_seg/router/routes.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/feed_content_controller.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/constant.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final userState = UserState.instance;
  final contextState = ContextState.instance;
  runApp(MyApp(userState: userState, contextState: contextState));
}

class MyApp extends StatelessWidget {
  final UserState userState;
  final ContextState contextState;

  const MyApp({Key? key, required this.userState, required this.contextState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(
          lazy: false,
          create: (BuildContext context) => userState,
        ),
        Provider<AppRouter>(
          lazy: false,
          create: (BuildContext context) => AppRouter(userState),
        ),
        ChangeNotifierProvider<ContextState>(
          lazy: false,
          create: (BuildContext context) => contextState,
        ),
        ChangeNotifierProvider<FeedContentController>(
          lazy: false,
          create: (context) => FeedContentController.instance,
        ),
        ChangeNotifierProvider<MatchState>(
          lazy: false,
          create: (context) => MatchState.instance,
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
