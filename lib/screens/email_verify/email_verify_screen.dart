import 'package:project_seg/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/**
 * This class represents a widget that is used to implement email
 * verification functionality and display a screen informing a user
 * that an email was sent to them.
 */

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  late UserState _userState;

  @override
  void initState() {
    super.initState();
    _userState = Provider.of<UserState>(context, listen: false);
    _userState.startCheckingForVerifiedEmail();
  }

  @override
  void dispose() {
    _userState.stopCheckingForVerifiedEmail();
    super.dispose();
  }

  /**
   * This method builds an information screen that an email waas sent
   * to the user. In order to move forward, the user is required to
   * confirm their email by clicking on the link in the mail.
   */

  @override
  Widget build(BuildContext context) {
    final UserState _userState = Provider.of<UserState>(context);

    return Scaffold(
        backgroundColor: lightBlue,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => _userState.signOut(),
                        icon: const Icon(
                          FontAwesomeIcons.signOutAlt,
                          color: whiteColour,
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
                        child: Lottie.asset(
                            'assets/lotties/mail-verification.json'),
                      ),
                      Text(
                        "You've got mail!",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.apply(color: whiteColour),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Before you can proceed, head over to your inbox to activate your account.",
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.apply(color: whiteColour),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 80)
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "We have sent the email to '${_userState.user?.user?.email}'. Didn't receive it yet?",
                        style: TextStyle(
                            color: whiteColour.withOpacity(0.7), fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      PillButtonOutlined(
                        text: "Resend email",
                        color: whiteColour,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 7),
                        textStyle: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.apply(color: whiteColour),
                        onPressed: () async =>
                            await _userState.sendVerificationEmail(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
