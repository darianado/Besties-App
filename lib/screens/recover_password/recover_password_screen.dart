import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/services/auth_service.dart';

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
      showEmailAlert(context, 'Please check your email for a password reset link');
    } on FirebaseAuthException catch (e) {
      final errorMsg = AuthExceptionHandler.generateExceptionMessageFromException(e);
      showEmailAlert(context, errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget your Password?'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(22.0, 35.0, 22.0, 35.0),
                child: Text(
                  'Enter your email address',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 5.0),
                child: TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(
                        Icons.email,
                        color: Color(0xFFFEFCFB),
                      ),
                      labelText: 'Enter your Email address'),
                  validator: (value) => !isEmail(_email.text) ? "Invalid Email" : null,
                  textInputAction: TextInputAction.next,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (((_formKey.currentState as FormState).validate()) == true) {
                    _sendEmailVerification(_email.text);
                  }
                },
                child: const Text("Continue"),
              ),
              TextButton(
                child: Text('back to Log In'),
                onPressed: () => context.goNamed("login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
