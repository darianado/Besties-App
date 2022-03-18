import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:project_seg/constants/textStyles.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';

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
            kWhiteColourShade2,
            kWhiteColourShade3,
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
                    style: kRegisterPageStyle,
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false),
            ),
            body: Center(
                child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(22, 0, 22, 30),
                  //  autovalidate: true,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign up',
                          style: kRegisterPageStyle,
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              icon: Icon(Icons.email, color: kTertiaryColour),
                              labelText: 'Email address'),
                          validator: (value) =>
                              !isEmail(_email.text) ? "Invalid Email" : null,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(height: 30),
                        TextFormField(
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
                        SizedBox(height: 30),
                        TextFormField(
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
                        SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
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
                                : Text("Register"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(kTertiaryColour),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(10.0)),
                              textStyle: MaterialStateProperty.all(
                                  Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.apply(fontWeightDelta: 2)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
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
                                      style: kTertiaryStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
            ))));
  }
}
