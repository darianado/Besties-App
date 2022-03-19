import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:lottie/lottie.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({Key? key}) : super(key: key);

  @override
  _RecoverPasswordScreenState createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final AuthService _authService = AuthService.instance;

  bool isEmail(String input) => EmailValidator.validate(input);

  _sendEmailVerification(String email) async {
    try {
      await _authService.resetPassword(email);
      showEmailAlert(
          context, 'Please check your email for a password reset link');
    } on FirebaseAuthException catch (e) {
      final errorMsg =
          AuthExceptionHandler.generateExceptionMessageFromException(e);
      showEmailAlert(context, errorMsg);
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
          kWhiteColour,
          kWhiteColourShade2,
          kWhiteColourShade3,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(22, 20, 22, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
                      borderRadius: BorderRadius.circular(10),
                      color: kTertiaryColour.withOpacity(0.1),
                    ),
                    child: TextFormField(
                      controller: _email,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.email,
                            color: kTertiaryColour,
                          ),
                          labelText: 'Enter your email address'),
                      validator: (value) =>
                          !isEmail(_email.text) ? "Invalid Email" : null,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: 35),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (((_formKey.currentState as FormState).validate()) ==
                            true) {
                          _sendEmailVerification(_email.text);
                        }
                      },
                      child: const Text("Send recovery email"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kTertiaryColour),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(10.0)),
                        textStyle: MaterialStateProperty.all(Theme.of(context)
                            .textTheme
                            .headline6
                            ?.apply(fontWeightDelta: 2)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.goNamed("login"),
                      child: const Text(
                        "Return to log in",
                        style: TextStyle(color: kTertiaryColour),
                      ),
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                          color: kTertiaryColour,
                          width: 1.5,
                        )),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(10.0)),
                        textStyle: MaterialStateProperty.all(Theme.of(context)
                            .textTheme
                            .headline6
                            ?.apply(fontWeightDelta: 2)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // TextButton(
                  //   child: Text('Return to Log In',
                  //       style: TextStyle(color: kTertiaryColour)),
                  //   onPressed: () => context.goNamed("login"),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
