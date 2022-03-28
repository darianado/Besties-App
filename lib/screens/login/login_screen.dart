import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/dialogs/dismiss_dialog.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  void signIn(UserState userState) async {
    setState(() {
      isLoading = true;
    });

    try {
      await userState.signIn(_email.text.trim(), _password.text.trim());
    } on FirebaseAuthException catch (e) {
      final errorMsg =
          AuthExceptionHandler.generateExceptionMessageFromException(e);
      showDialog(
        context: context,
        builder: (context) => DismissDialog(message: errorMsg),
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    final _userState = Provider.of<UserState>(context);

    void _submitForm(GlobalKey<FormState> key) {
      if (_formKey.currentState!.validate()) {
        signIn(_userState);
      }
    }

    return Theme(
      data: ThemeData(
        textTheme:
            Theme.of(context).textTheme.apply(bodyColor: simpleWhiteColour),
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
              primaryColour,
              loginBlue,
              activeCardColor,
            ],
          )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        leftRightPadding, 0, leftRightPadding, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/logo/white_text_logo.svg',
                            fit: BoxFit.fitHeight),
                        const SizedBox(height: 50),
                        Text(
                          'Log in',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.apply(color: whiteColour),
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                            fillColor: whiteColour,
                            focusColor: whiteColour,
                            border: UnderlineInputBorder(),
                            icon: Icon(Icons.email, color: whiteColour),
                            labelText: 'Email address',
                          ),
                          validator: validateEmail,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(Icons.lock, color: whiteColour),
                            labelText: 'Password',
                          ),
                          validator: validatePassword,
                          textInputAction: TextInputAction.next,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            child: Text(
                              'Forget password?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.apply(color: whiteColour),
                            ),
                            onPressed: () =>
                                context.pushNamed(recoverPasswordScreenName),
                          ),
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: PillButtonFilled(
                            text: "Log in",
                            isLoading: isLoading,
                            backgroundColor: whiteColour,
                            textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: secondaryColour),
                            onPressed: () => _submitForm(_formKey),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            PillButtonOutlined(
                              text: "Sign up",
                              color: whiteColour,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 7),
                              textStyle: Theme.of(context).textTheme.labelLarge,
                              onPressed: () =>
                                  context.pushNamed(registerScreenName),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
