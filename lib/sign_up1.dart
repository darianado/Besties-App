import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_seg/authenticator.dart';



class SignUp1 extends StatefulWidget {
  @override
  _SignUp1State createState() => _SignUp1State();

}

class _SignUp1State extends State<SignUp1> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  
 

  bool isEmail(String input) => EmailValidator.validate(input);

  void _createAccount(String email, String password) async {
      final status = await FirebaseAuthHelper().createAccount( email: email, pass: password);
      if (status == AuthResultStatus.successful) {
        // Navigate to page
        Navigator.pushNamed(context, '/first');
        } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(
            status);
        _showAlertDialog(errorMsg);
      }
  }

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
        key: _formKey,
        //autovalidator: _autoValidate,
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
              const SizedBox(),
              ElevatedButton(
                  onPressed: (){
                    
                    if(((_formKey.currentState as FormState).validate()) == true) {
                        _createAccount(_email.text, _password.text);
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


