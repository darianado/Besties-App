import 'package:flutter/material.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/**
 *
 */

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
    _appContext = Provider.of<ContextState>(context, listen: false);
    _appContext.onAppStart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
