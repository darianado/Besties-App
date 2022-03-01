import 'package:flutter/material.dart';
import 'package:project_seg/authenticator.dart';
import 'package:project_seg/models/my_user.dart';
import 'package:project_seg/wrapper.dart';
import 'package:provider/provider.dart';
import 'sign_up1.dart';
import 'sign_up2.dart';
import 'sign_up3.dart';
import 'sign_up4.dart';
import 'log_in.dart';
import 'feed.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: FirebaseAuthHelper().user,
      initialData: null,
      child: MaterialApp(
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => Wrapper(),
          '/': (context) => SignUp1(),
          '/first': (context) => SignUp2(),
          '/signup3': (context) => SignUp3(),
          '/signup4': (context) => SignUp4(),
          '/feed': (context) => Feed(),
          '/login' : (context) => Log_In(),
        },
      )
    );
    
  }
}
