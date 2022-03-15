// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:project_seg/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool isLoading = false;

  bool isEmail(String input) => EmailValidator.validate(input);
  /*
  _createAccount(String email, String password) async {
    final status = await FirebaseAuthHelper().createAccount(email: email, pass: password);
    if (status == AuthResultStatus.successful) {
      showEmailAlert(context, 'Please click on the link in your email to complete sign up! ');
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      showAlert(context, errorMsg);
    }
  }
*/
  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  void signIn(UserState userState) async {
    setState(() {
      isLoading = true;
    });

    try {
      await userState.signUp(_email.text.trim(), _password.text.trim());
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      final errorMsg =
          AuthExceptionHandler.generateExceptionMessageFromException(e);
      showAlert(context, errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final _userState = Provider.of<UserState>(context);

    void submitForm(GlobalKey<FormState> key) {
      if (_formKey.currentState!.validate()) {
        signIn(_userState);
      }
    }

    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.4, 0.8, 1],
          colors: [
            kWhiteColour,
            Color(0xFFE2F9FE),
            Color(0xFFD8F8FF),
          ],
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  0.1 * screenHeight), // here the desired height
              child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                  ),
                  title: const Text(
                    'BESTIES',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: kLightBlue,
                    ),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false),
            ),
            body: Center(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                //  autovalidate: true,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(22.0, 28.0, 22.0, 30.0),
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              fontSize: 35,
                              color: kTertiaryColour,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 25.0),
                        child: TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.email, color: kTertiaryColour),
                              labelText: 'Email address'),
                          validator: (value) =>
                              !isEmail(_email.text) ? "Invalid Email" : null,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 25.0),
                        child: TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.lock,
                              color: kTertiaryColour,
                            ),
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, bottom: 40.0),
                        child: TextFormField(
                          controller: _confirmPassword,
                          obscureText: true,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(
                                Icons.lock,
                                color: kTertiaryColour,
                              ),
                              labelText: 'Confirm password'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value != _password.text) {
                              return "Please type the same password";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 0.85 * screenWidth,
                        height: 0.07 * screenHeight,
                        child: ElevatedButton(
                          onPressed: () => submitForm(_formKey),
                          child: (isLoading)
                              ? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: kWhiteColour,
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text("Register", style: GoogleFonts.nunito()),
                          style: ElevatedButton.styleFrom(
                              primary: kTertiaryColour,
                              onPrimary: kWhiteColour,
                              fixedSize: const Size(300, 100),
                              shadowColor: kTertiaryColour,
                              elevation: 12,
                              textStyle: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(35.0),
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                              flex: 2,
                              child: Text(
                                'Have an account? Log in now?',
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () => context.goNamed("login"),
                                style: OutlinedButton.styleFrom(
                                  primary: kTertiaryColour,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  side: const BorderSide(
                                      color: kTertiaryColour, width: 1.5),
                                ),
                                child: const Text("Log in",
                                    style: TextStyle(color: kTertiaryColour)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ))));
  }
}
