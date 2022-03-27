import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/widget/icon_content.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  bool isLoading = false;

  bool isEmail(String input) => EmailValidator.validate(input);

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
  }

  void signUp(UserState userState) async {
    setState(() {
      isLoading = true;
    });

    try {
      await userState.signUp(_email.text.trim(), _password.text.trim());
    } on FirebaseAuthException catch (e) {
      final errorMsg = AuthExceptionHandler.generateExceptionMessageFromException(e);
      showAlert(context, errorMsg);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    void submitForm(GlobalKey<FormState> key) {
      if (_formKey.currentState!.validate()) {
        signUp(_userState);
      }
    }

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.4, 0.8, 1],
        colors: [
          whiteColour,
          whiteColourShade2,
          whiteColourShade3,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          title: Text(
            'BESTIES',
            style: Theme.of(context).textTheme.headline3,
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.fromLTRB(leftRightPadding, 0, leftRightPadding, 30),
                //  autovalidate: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign up',
                      style: Theme.of(context).textTheme.headline4?.apply(color: secondaryColour, fontWeightDelta: 2),
                    ),
                    SizedBox(height: 40),
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        icon: buildIcons(Icons.email, tertiaryColour),
                        labelText: 'Email address',
                      ),
                      validator: validateEmail,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        icon: buildIcons(Icons.lock, tertiaryColour),
                        labelText: 'Password',
                      ),
                      validator: validatePassword,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _confirmPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        icon: buildIcons(Icons.lock, tertiaryColour),
                        labelText: 'Confirm password',
                      ),
                      validator: (value) => validateRepeatedPassword(value, _password.text),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      child: PillButtonFilled(
                        text: "Register",
                        isLoading: isLoading,
                        backgroundColor: tertiaryColour,
                        textStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: whiteColour
                        ),
                        onPressed: () => submitForm(_formKey),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Already registered?',
                          ),
                          PillButtonOutlined(
                            text: "Log in",
                            color: tertiaryColour,
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                            textStyle: Theme.of(context).textTheme.labelLarge,
                            onPressed: () => context.goNamed(loginScreenName),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
