import 'package:project_seg/constants/colours.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import '../../constants/borders.dart';
import '../../constants/textStyles.dart';
import '../components/widget/icon_content.dart';
import 'package:go_router/go_router.dart';

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
                    icon: buildIcons(FontAwesomeIcons.signOutAlt, kWhiteColour),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: Lottie.asset('assets/lotties/mail-verification.json'),
                  ),
                  const Text(
                    "You've got mail!",
                    style: kWhiteBoldStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Before you can proceed, head over to your inbox to activate your account.",
                    style: kEmailCheckStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 100)
                ],
              ),
              Column(
                children: [
                  Text(
                    "We have sent the email to '${_userState.user?.user?.email}'. Didn't receive it yet?",
                    style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  PillButtonOutlined(
                    text: "Resend email",
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    textStyle: Theme.of(context).textTheme.labelLarge?.apply(color: Colors.white),
                    onPressed: () => _authService.sendVerificationEmail(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
