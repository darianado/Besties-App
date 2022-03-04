import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:project_seg/alerts.dart';
import 'package:project_seg/authenticator.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final FirebaseAuthHelper _auth = FirebaseAuthHelper();

  bool isEmail(String input) => EmailValidator.validate(input);

  _loginAccount(String email, String password) async {
    final status = await _auth.login(email: email, pass: password);
    if (status == AuthResultStatus.successful) {
      Navigator.pushNamed(context, '/feed');
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
      showAlert(context, errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Theme(
        data: ThemeData(
          brightness: Brightness.dark,
          ),
        child: Builder(
          builder: (context){
            return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.4, 0.8, 1],
          colors: [
            Color(0xFF041731),
            Color(0xFF026689),
            Color(0xFF00CFFF),
          ],
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  0.1 * screenHeight), // here the desired height
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
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(22.0, 35.0, 22.0, 35.0),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 5.0),
                        child: TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                              fillColor: Color(0xFFFEFCFB),
                              focusColor: Color(0xFFFEFCFB),
                              border: UnderlineInputBorder(),
                              icon: Icon(
                                Icons.email,
                                color: Color(0xFFFEFCFB),
                              ),
                              labelText: 'Email address'),
                          validator: (value) =>
                              !isEmail(_email.text) ? "Invalid Email" : null,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 2.0),
                        child: TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.lock,
                              color: Color(0xFFFEFCFB),
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
                        padding:
                            const EdgeInsets.only(right: 25.0, bottom: 40.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: const Text('Forget password?',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xFFFEFCFB))),
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 0.85 * screenWidth,
                          height: 0.08 * screenHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              if (((_formKey.currentState as FormState)
                                      .validate()) ==
                                  true) {
                                _loginAccount(_email.text, _password.text);
                              }
                            },
                            child: const Text("Log In"),
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xFFFEFCFB),
                                onPrimary: const Color(0xFF041731),
                                fixedSize: const Size(300, 100),
                                shadowColor: const Color(0xFF041731),
                                elevation: 12,
                                textStyle: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
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
                                onPressed: () {
                                  Navigator.pushNamed(context, '/');
                                },
                                style: OutlinedButton.styleFrom(
                                  primary: const Color(0xFFFEFCFB),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  side: const BorderSide(
                                      color: Color(0xFFFEFCFB), width: 1.5),
                                ),
                                child: const Text("Sign up",
                                    style: TextStyle(color: Color(0xFFFEFCFB))),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ))));
          }
        ),
    )

    ;
  }
}
