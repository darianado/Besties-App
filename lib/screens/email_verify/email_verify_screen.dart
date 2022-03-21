import 'dart:async';
import 'package:project_seg/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import '../../constants/borders.dart';
import '../../constants/textStyles.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final AuthService _authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
    _authService.startCheckingForVerifiedEmail();
  }

  @override
  void dispose() {
    super.dispose();
    _authService.stopCheckingForVerifiedEmail();
  }

  @override
  Widget build(BuildContext context) {
    final UserState _userState = Provider.of<UserState>(context);

    return Scaffold(
      backgroundColor: kLightBlue,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _userState.signOut(),
                    icon: Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: kWhiteColour,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child:
                        Lottie.asset('assets/lotties/mail-verification.json'),
                  ),
                  Text(
                    "You've got mail!",
                    style: kWhiteBoldStyle,
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Before you can proceed, head over to your inbox to activate your account.",
                    style: kEmailCheckStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 100)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: OutlinedButton(
                  onPressed: () => _authService.sendVerificationEmail(),
                  child: Text(
                    "Resend email",
                    style: kResendEmailStyle,
                  ),
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(BorderSide(
                      color: kWhiteColour.withOpacity(0.8),
                      width: 1,
                    )),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)),
                    textStyle: MaterialStateProperty.all(
                        Theme.of(context).textTheme.bodyMedium),
                    shape: MaterialStateProperty.all(kRoundedRectangulareBorder40)
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
