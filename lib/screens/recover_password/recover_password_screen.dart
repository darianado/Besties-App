import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/dialogs/dismiss_dialog.dart';
import 'package:project_seg/screens/components/widget/icon_content.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/utility/form_validators.dart';
import '../../constants/borders.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  _RecoverPasswordScreenState createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final AuthService _authService = AuthService.instance;

  bool isEmail(String input) => EmailValidator.validate(input);

  _sendEmailVerification(String email) async {
    String message = 'Please check your email for a password reset link';

    try {
      await _authService.resetPassword(email);
    } on FirebaseAuthException catch (e) {
      final errorMsg = AuthExceptionHandler.generateExceptionMessageFromException(e);
      message = errorMsg;
    }

    showDialog(context: context, builder: (context) => DismissDialog(message: message));
  }

  void _submitForm(GlobalKey<FormState> key) {
    if (_formKey.currentState!.validate()) {
      _sendEmailVerification(_email.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.4, 0.8, 1],
        colors: [
          whiteColour,
          whiteColourShade2,
          whiteColourShade3,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(leftRightPadding, 20, leftRightPadding, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.headline4?.apply(fontWeightDelta: 2),
                    ),
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Lottie.asset('assets/lotties/forgot-password.json'),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: circularBorderRadius10,
                        color: tertiaryColour.withOpacity(0.1),
                      ),
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                            border: InputBorder.none, icon: buildIcons(Icons.email, tertiaryColour), labelText: 'Enter your email address'),
                        validator: validateEmail,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(height: 35),
                    Container(
                      width: double.infinity,
                      child: PillButtonFilled(
                        text: "Send recovery email",
                        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        onPressed: () => _submitForm(_formKey),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: PillButtonOutlined(
                        text: "Return to log in",
                        color: tertiaryColour,
                        textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: tertiaryColour),
                        onPressed: () => context.goNamed(loginScreenName),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
