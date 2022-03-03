
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_seg/authenticator.dart';
import 'package:project_seg/alerts.dart';



class Edit_Password extends StatefulWidget {
  @override
  _Edit_PasswordState createState() => _Edit_PasswordState();

}

class _Edit_PasswordState extends State<Edit_Password> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();





  @override
  void dispose() {
    super.dispose();
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Center(child: Text('Edit your password')),
        ),


        body: Center(
            child: SingleChildScrollView(
              child: Form (
                key: _formKey,
                //  autovalidate: true,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                        child: TextFormField(
                          controller: _oldPassword,
                          obscureText: true,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            icon: const Icon(Icons.lock),
                            labelText: 'Enter your current password',
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
                          controller: _newPassword,
                          obscureText: true,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            icon: const Icon(Icons.lock),
                            labelText: 'Enter your new password',
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
                          controller: _confirmNewPassword,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              icon: const Icon(Icons.lock),
                              labelText: 'Confirm your new password:'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            if( value != _newPassword.text){
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
                              Navigator.pushNamed(context, '/profile_page');
                            }
                          },
                          child: Text(" CHANGE YOUR PASSWORD"),
                      )
                    ]
                ),
              ),
            )
        )



    );

  }
}


