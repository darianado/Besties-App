import 'package:flutter/material.dart';
import 'package:project_seg/models/App/app_context.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late UserState _userState;
  late ContextState _appContext;

  @override
  void initState() {
    _userState = Provider.of<UserState>(context, listen: false);
    _userState.onAppStart();

    _appContext = Provider.of<ContextState>(context, listen: false);
    _appContext.onAppStart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
