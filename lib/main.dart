import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/App/app_context.dart';
import 'package:project_seg/router/routes.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';
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

  const MyApp({Key? key, required this.userState, required this.contextState})
      : super(key: key);

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
        )
      ],
      child: Builder(
        builder: (context) {
          final router = Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: GoogleFonts.nunitoSansTextTheme(
                    (Theme.of(context).textTheme))
                /*
              primaryTextTheme: const TextTheme(
                bodyText1: TextStyle(),
                bodyText2: TextStyle(),
              ).apply(
                bodyColor: Colors.orange,
                displayColor: Colors.red,
              ),
              */
                /*
              // Define the default brightness and colors.
              brightness: Brightness.light,
              scaffoldBackgroundColor: kWhiteColour,
              primaryColor: kSecondaryColour,
              fontFamily: 'Georgia',
              textTheme: const TextTheme(
                headline1: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                headline6: TextStyle(fontSize: 25.0, fontStyle: FontStyle.italic),
                bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
              ),
              */
                ),
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        },
      ),
    );
  }
}
