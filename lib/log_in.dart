import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:project_seg/authenticator.dart';

class Log_In extends StatefulWidget {
  const Log_In({Key? key}) : super(key: key);

  @override
  _Log_InState createState() => _Log_InState();
}

class _Log_InState extends State<Log_In> {

  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  var authHandler =  Authenticator();


 bool isEmail(String input) => EmailValidator.validate(input);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Log In'),
      ),

      body:
      Form (
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: TextFormField(
                   controller: _email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      icon: const Icon(Icons.email),
                      labelText: 'Email address:'),
                      validator: (value) => !isEmail(_email.text) ? "Invalid Email" : null,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    icon: new Icon(Icons.lock),
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
              ElevatedButton(
                   onPressed: (){
                    if(((_formKey.currentState as FormState).validate()) == true) {
                      authHandler.handleLogIn(_email.text, _password.text)
                     .then((var user) {
                        Navigator.pushNamed(context, '/feed');
                     }).catchError((e) => print(e));
                    }
                  },
                  child: Text("Log In")
              ),
              TextButton(
                  child: Text('New here? Sign up now'),
                onPressed: (){
                  Navigator.pushNamed(context, '/');
                },
              ),
            ]
        ),
      ),
    );
  }
}
