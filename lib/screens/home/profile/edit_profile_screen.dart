import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/chat/components/round_action_button.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final AuthService _authService = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return ProfileInformation(
      userData: _userState.user?.userData,
      editable: true,
      onImageSection: Container(
        color: opacBlack,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          "EDIT",
          style: Theme.of(context).textTheme.bodyMedium?.apply(color: whiteColour),
        ),
      ),
      rightAction: Padding(
        padding: const EdgeInsets.only(right: leftRightPadding),
        child: RoundActionButton(
          onPressed: () => context.goNamed(homeScreenName, params: {pageParameterKey: profileScreenName}),
          child: Icon(
            FontAwesomeIcons.check,
            color: whiteColour,
            size: 22,
          ),
        ),
      ),
      bottomSection: PillButtonOutlined(
        text: "Delete account",
        expandsWidth: true,
        color: Colors.red,
        textStyle: Theme.of(context).textTheme.titleMedium?.apply(color: Colors.red),
        icon: const Icon(
          FontAwesomeIcons.ban,
          color: Colors.red,
          size: 18,
        ),
        onPressed: () => {_showDialog()},
      ),
    );
  }

  _deleteUser(String password) async {
    try {
      await _authService.deleteAccount(password);
    } on FirebaseAuthException catch (e) {
      final errorMsg = AuthExceptionHandler.generateExceptionMessageFromException(e);
      showAlert(context, errorMsg);
    }
  }

  //delete account confirmation dialog
  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Delete account',
              style: Theme.of(context).textTheme.headline4?.apply(fontWeightDelta: 2),
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Confirm Password',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: tertiaryColour.withOpacity(0.1),
                    ),
                    child: TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          color: tertiaryColour,
                        ),
                        labelText: 'Password',
                      ),
                      validator: validatePassword,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Are you sure you want to leave us? \n All your details will be deleted!',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: Theme.of(context).textTheme.titleMedium?.apply(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      PillButtonFilled(
                        text: "Delete",
                        backgroundColor: Colors.red,
                        textStyle: Theme.of(context).textTheme.titleMedium?.apply(color: whiteColour),
                        onPressed: () {
                          if (((_formKey.currentState as FormState).validate()) == true) {
                            _deleteUser(_password.text);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
