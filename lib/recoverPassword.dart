import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:project_seg/authenticator.dart';
import 'package:project_seg/alerts.dart';

class recoverPassword extends StatefulWidget {
  const recoverPassword({Key? key}) : super(key: key);

  @override
  _recoverPasswordState createState() => _recoverPasswordState();
}

class _recoverPasswordState extends State<recoverPassword> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
   final FirebaseAuthHelper _auth = FirebaseAuthHelper();

  bool isEmail(String input) => EmailValidator.validate(input);


  _sendEmailVerification(String email) async {
    final status = await _auth.resetPassword(email);
    if (status == null) {
      showEmailAlert(context, 'Please check your email for a password reset link');
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
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
            validator: (value) =>
            !isEmail(_email.text) ? "Invalid Email" : null,
            textInputAction: TextInputAction.next,
          ),
        ),
                  ElevatedButton(
                    onPressed: (){
                     if (((_formKey.currentState as FormState) .validate()) ==true) {
                         _sendEmailVerification(_email.text);
                     }                      
                      
                    },
                    child: const Text("Continue"),
                  ),
                  TextButton(child: Text('back to Log In'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/login');
                    },
                  ),


        ]

        )

      )


    )
    );
  }
}
