import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Sign_Up1 extends StatefulWidget {
  @override
  _Sign_Up1State createState() => _Sign_Up1State();

}

class _Sign_Up1State extends State<Sign_Up1> {
  final GlobalKey _key = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool isEmail(String input) => EmailValidator.validate(input);

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Center(child: Text('Create your account')),
      ),

      body:
      Form (
        key: _key,
      //  autovalidate: true,
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
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: TextFormField(
                  controller: _confirmPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      icon: new Icon(Icons.lock),
                      labelText: 'Confirm password:'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if( value != _password.text){
                      return "Please type the same password";
                    }
                    return null;
                  },

                ),
              ),
              SizedBox(),
              ElevatedButton(
                  onPressed: (){
                    if(((_key.currentState as FormState).validate()) == true) {
                      Navigator.pushNamed(context, '/first');
                    }
                  },
                  child: Text(" NEXT")
              )
            ]
        ),
      ),
    );
  }
}


