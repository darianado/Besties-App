import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/textStyles.dart';
import 'package:project_seg/screens/components/widget/icon_content.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
import '../../constants/borders.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;

    final _userState = Provider.of<UserState>(context);

    void submitForm(GlobalKey<FormState> key) {
      if (_formKey.currentState!.validate()) {
        signIn(_userState);
      }
    }

    return Theme(
      data: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kSimpleWhiteColour),
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
                kLoginBlue,
                kActiveCardColor,
              ],)
            ),
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
                        style: kWhiteBoldStyle,
                      ),
                      centerTitle: true,
                      automaticallyImplyLeading: false),
                ),
                body: Center(
                 child: SingleChildScrollView(
                   child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Log in',
                              style: kLogInScreenStyle,
                            ),
                            const SizedBox(height: 40),
                            TextFormField(
                              controller: _email,
                              decoration: InputDecoration(
                                  fillColor: kWhiteColour,
                                  focusColor: kWhiteColour,
                                  border: const UnderlineInputBorder(),
                                  icon: buildIcons(Icons.email, kWhiteColour),
                                  labelText: 'Email address'),
                              validator: (value) => !isEmail(_email.text)
                                  ? "Invalid Email"
                                  : null,
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              controller: _password,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                icon: buildIcons(Icons.lock, kWhiteColour),
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
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                child: const Text('Forget password?',
                                    style: kLogInPasswordStyle,
                                ),
                                onPressed: () {
                                  context.pushNamed("recover_password");
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                                width: double.infinity,
                                height: 0.07 * screenHeight,
                                child: ElevatedButton(
                                  onPressed: () => submitForm(_formKey),
                                  child: (isLoading)
                                      ? const SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: CircularProgressIndicator(
                                            color: kSecondaryColour,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Text(
                                          "Log In",
                                          style: kTertiaryColourTextStyle,
                                        ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(kWhiteColour),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(10.0)),
                                    textStyle: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.apply(fontWeightDelta: 2)),
                                    shape: MaterialStateProperty.all(kRoundedRectangulareBorder40),
                                  ),
                                )),
                            const SizedBox(height: 30),
                            Container(
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
                                      style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                          color: kWhiteColour,
                                          width: 1,
                                        )),
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(const EdgeInsets.all(10.0)),
                                        textStyle: MaterialStateProperty.all(
                                            Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        shape: MaterialStateProperty.all(kRoundedRectangulareBorder40),
                                      ),
                                      child: const Text("Sign up",
                                          style: kWhiteColourTextStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                  ),
                )
                )
            )
        );
      }),
    );
  }
}
