// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:project_seg/authenticator.dart';
import 'package:project_seg/alerts.dart';



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

   _createAccount(String email, String password) async {
      final status = await FirebaseAuthHelper().createAccount( email: email, pass: password);
      if (status == AuthResultStatus.successful) {
        // Navigate to page
        Navigator.pushNamed(context, '/first');
    
        
        } else {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(
            status);
        showAlert(context, errorMsg);
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.4, 0.8, 1],
        colors: [
          Color(0xFFFEFCFB),
          Color(0xFFE2F9FE),
          Color(0xFFD8F8FF),
        ],
    )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0.1 * screenHeight),  // here the desired height
              child: AppBar(
                  backgroundColor: Colors.transparent,
                  systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                  ),
                  title: const Text(
                    'BESTIES',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false),
            ),

        body: Center(
          child: SingleChildScrollView(
            child: Form (
              key: _formKey,
            //  autovalidate: true,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget> [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(22.0, 28.0, 22.0, 30.0),
                      child: Text(
                        'Sign up',
                        style: TextStyle(fontSize: 35, color: Color(0xFF004376), fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 25.0),
                      child: TextFormField(
                        controller: _email,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.email,
                              color: Color(0xFF004376)
                            ),
                            labelText: 'Email address'),
                          validator: (value) => !isEmail(_email.text) ? "Invalid Email" : null,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 25.0),
                      child: TextFormField(
                        controller: _password,
                        obscureText: true,
                        decoration:  const InputDecoration(
                          border: UnderlineInputBorder(),
                          icon: Icon(
                            Icons.lock,
                            color: Color(0xFF004376),
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
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 40.0),
                      child: TextFormField(
                        controller: _confirmPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.lock,
                              color: Color(0xFF004376),
                            ),
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

                    SizedBox(
                        width: 0.80 * screenWidth,
                        height: 0.07 * screenHeight,
                        child: ElevatedButton(
                          onPressed: (){

                            if(((_formKey.currentState as FormState).validate()) == true) {
                              _createAccount(_email.text, _password.text);
                            }
                          },
                          child: const Text("Next"),
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF041731),
                              onPrimary: const Color(0xFFFEFCFB),
                              fixedSize: const Size(300, 100),
                              shadowColor: const Color(0xFF041731),
                              elevation: 12,
                              textStyle: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        )),


                  // const SizedBox(),
                  // ElevatedButton(
                  //     onPressed: (){
                  //
                  //       if(((_formKey.currentState as FormState).validate()) == true) {
                  //         _createAccount(_email.text, _password.text);
                  //       }
                  //     },
                  //     child: Text(" NEXT"),
                  // ),

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
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              style: OutlinedButton.styleFrom(
                                primary: const Color(0xFF041731),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30))),
                                side: const BorderSide(
                                    color: Color(0xFF041731), width: 1.5),
                              ),
                              child: const Text("Log in",
                                  style: TextStyle(color: Color(0xFF041731))),
                            ),
                          ),
                        ],
                      ),
                    )

              ]
            ),
          ),
      )
      )
    
    
    
    ));




  }
}


