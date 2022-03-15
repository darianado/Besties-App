import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isLoading = false;

  bool isEmail(String input) => EmailValidator.validate(input);

  void signIn(UserState userState) async {
    setState(() {
      isLoading = true;
    });

    try {
      await userState.signIn(_email.text.trim(), _password.text.trim());
    } on FirebaseAuthException catch (e) {
      final errorMsg =
          AuthExceptionHandler.generateExceptionMessageFromException(e);
      showAlert(context, errorMsg);
    }

    setState(() {
      isLoading = false;
    });
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

    return Theme(
      data: ThemeData(
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
      ),
      child: Builder(builder: (context) {
        return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.4, 0.8, 1],
              colors: [
                kPrimaryColour,
                Color(0xFF026689),
                Color(0xFF00CFFF),
              ],
            )),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(0.1 * screenHeight),
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
                            color: kWhiteColour),
                      ),
                      centerTitle: true,
                      automaticallyImplyLeading: false),
                ),
                body: Center(
                    child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding:
                                EdgeInsets.fromLTRB(22.0, 35.0, 22.0, 35.0),
                            child: Text(
                              'Log in',
                              style: TextStyle(
                                  fontSize: 35, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 35.0, 30.0, 10.0),
                            child: TextFormField(
                              controller: _email,
                              decoration: const InputDecoration(
                                  fillColor: kWhiteColour,
                                  focusColor: kWhiteColour,
                                  border: UnderlineInputBorder(),
                                  icon: Icon(
                                    Icons.email,
                                    color: kWhiteColour,
                                  ),
                                  labelText: 'Email address'),
                              validator: (value) => !isEmail(_email.text)
                                  ? "Invalid Email"
                                  : null,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 10.0, 30.0, 2.0),
                            child: TextFormField(
                              controller: _password,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                icon: Icon(
                                  Icons.lock,
                                  color: kWhiteColour,
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
                                right: 25.0, bottom: 40.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                child: const Text('Forget password?',
                                    style: TextStyle(
                                        fontSize: 12, color: kWhiteColour)),
                                onPressed: () {
                                  context.pushNamed("recover_password");
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                              width: 0.85 * screenWidth,
                              height: 0.08 * screenHeight,
                              child: ElevatedButton(
                                onPressed: () => submitForm(_formKey),
                                child: (isLoading)
                                    ? SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Text("Log In"),
                                style: ElevatedButton.styleFrom(
                                    primary: kWhiteColour,
                                    onPrimary: kPrimaryColour,
                                    fixedSize: const Size(300, 100),
                                    shadowColor: kPrimaryColour,
                                    elevation: 12,
                                    textStyle: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Roboto'),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                              )),
                          Container(
                            padding: const EdgeInsets.all(35.0),
                            child: Row(
                              children: <Widget>[
                                const Expanded(
                                  flex: 2,
                                  child: Text(
                                    'New here? Sign up now?',
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        context.pushNamed("register"),
                                    style: OutlinedButton.styleFrom(
                                      primary: kWhiteColour,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      side: const BorderSide(
                                          color: kWhiteColour, width: 1.5),
                                    ),
                                    child: const Text("Sign up",
                                        style: TextStyle(color: kWhiteColour)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ))));
      }),
    );
  }
}
