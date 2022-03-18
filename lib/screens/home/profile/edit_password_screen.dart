import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/constants/colours.dart';

class EditPasswordScreen extends StatefulWidget {
  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  final AuthService _authService = AuthService.instance;

  @override
  void dispose() {
    super.dispose();
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
  }

  _changePassword(String currentPassword, String newPassword) async {
    try {
      await _authService.changePassword(currentPassword, newPassword);
    } on FirebaseAuthException catch (e) {
      final errorMsg =
          AuthExceptionHandler.generateExceptionMessageFromException(e);
      showAlert(context, errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
          appBar: AppBar(),
          body: Center(
              child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              //  autovalidate: true,
              child: Padding(
                padding: EdgeInsets.fromLTRB(22, 30, 22, 30),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Change your password',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        controller: _oldPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.lock,
                              color: kSecondaryColour,
                            ),
                            labelText: 'Enter your current password'),
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
                        controller: _newPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.lock,
                              color: kSecondaryColour,
                            ),
                            labelText: 'Enter your new password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value == _oldPassword.text) {
                            return "Please enter a different password to old one.";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _confirmNewPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.lock,
                              color: kSecondaryColour,
                            ),
                            labelText: 'Confirm your new password:'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value != _newPassword.text) {
                            return "Please type the same password";
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        height: 0.07 * screenHeight,
                        child: ElevatedButton(
                          onPressed: () {
                            if (((_formKey.currentState as FormState)
                                    .validate()) ==
                                true) {
                              _changePassword(
                                  _oldPassword.text, _newPassword.text);
                              context.pushNamed("home",
                                  params: {'page': 'profile'});
                            }
                          },
                          child: Text("Update"),
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
                    ]),
              ),
            ),
          ))),
    );
  }
}
