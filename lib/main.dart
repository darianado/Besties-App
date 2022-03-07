import 'package:flutter/material.dart';
import 'package:project_seg/Personal_information/edit_password.dart';
import 'package:project_seg/Personal_information/edit_preferences.dart';
import 'package:project_seg/Personal_information/edit_profile.dart';
import 'package:project_seg/Personal_information/profile_page.dart';
import 'package:project_seg/authenticator.dart';
import 'package:project_seg/recoverPassword.dart';
import 'package:project_seg/models/my_user.dart';
import 'package:project_seg/router/routes.dart';
import 'package:project_seg/services/UserState.dart';
import 'package:project_seg/wrapper.dart';
import 'package:provider/provider.dart';
import 'Sign_Up/register_screen.dart';
import 'Sign_Up/register_basic_info_screen.dart';
import 'Sign_Up/register_description_screen.dart';
import 'Sign_Up/register_interests_screen.dart';
import 'log_in.dart';
import 'feed.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final userState = UserState();
  runApp(MyApp(userState: userState));
}

class MyApp extends StatelessWidget {
  final UserState userState;

  const MyApp({Key? key, required this.userState}) : super(key: key);

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
        )
      ],
      child: Builder(
        builder: (context) {
          final router = Provider.of<AppRouter>(context, listen: false).router;
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryTextTheme: const TextTheme(
                bodyText1: TextStyle(),
                bodyText2: TextStyle(),
              ).apply(
                bodyColor: Colors.orange,
                displayColor: Colors.red,
              ),
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
            ),
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        },
      ),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
        value: FirebaseAuthHelper().user,
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryTextTheme: const TextTheme(
              bodyText1: TextStyle(),
              bodyText2: TextStyle(),
            ).apply(
              bodyColor: Colors.orange,
              displayColor: Colors.red,
            ),
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
          ),
          initialRoute: '/landing',
          routes: {
            '/landing': (context) => Wrapper(),
            '/': (context) => SignUp1(),
            '/first': (context) => SignUp2(),
            '/signup3': (context) => SignUp3(),
            '/signup4': (context) => SignUp4(),
            '/feed': (context) => Feed(),
            '/login': (context) => LogIn(),
            '/profile_page': (context) => ProfilePage(),
            '/edit_profile': (context) => EditProfile(),
            '/edit_preferences': (context) => EditPreferences(),
            '/edit_password': (context) => Edit_Password(),
            '/recover_password': (context) => recoverPassword(),
          },
        ));
  }
}
*/