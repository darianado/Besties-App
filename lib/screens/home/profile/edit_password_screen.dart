import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/dialogs/dismiss_dialog.dart';
import 'package:project_seg/utility/auth_exception_handler.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';
import '../../../constants/borders.dart';

/**
 * This class represents a model of a reusable widget that allows
 * the user to change their password.
 */

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
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

  _changePassword(String currentPassword, String newPassword) async {
    try {
      await Provider.of<UserState>(context)
          .changePassword(currentPassword, newPassword);
    } on FirebaseAuthException catch (e) {
      final errorMsg =
          AuthExceptionHandler.generateExceptionMessageFromException(e);
      showDialog(
        context: context,
        builder: (context) => DismissDialog(message: errorMsg),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
        body: Center(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                foregroundColor: tertiaryColour,
                backgroundColor: whiteColour,
                expandedHeight: 10,
                collapsedHeight: 80,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ),
                leading: IconButton(
                  onPressed: () => context.pushNamed(homeScreenName,
                      params: {pageParameterKey: profileScreenName}),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: primaryColour,
                  ),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                        leftRightPadding, 0, leftRightPadding, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Change your password',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.apply(fontWeightDelta: 2),
                        ),
                        const SizedBox(height: 50),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: circularBorderRadius10,
                            color: tertiaryColour.withOpacity(0.1),
                          ),
                          child: TextFormField(
                            controller: _oldPassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.lock,
                                  color: secondaryColour,
                                ),
                                labelText: 'Current password'),
                            validator: validatePassword,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: circularBorderRadius10,
                            color: tertiaryColour.withOpacity(0.1),
                          ),
                          child: TextFormField(
                            controller: _newPassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.lock,
                                  color: secondaryColour,
                                ),
                                labelText: 'New password'),
                            validator: (value) =>
                                validateExistsAndDifferentFrom(
                                    value, _oldPassword.text),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: circularBorderRadius10,
                            color: tertiaryColour.withOpacity(0.1),
                          ),
                          child: TextFormField(
                            controller: _confirmNewPassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.lock,
                                  color: secondaryColour,
                                ),
                                labelText: 'Confirm new password'),
                            validator: (value) => validateRepeatedPassword(
                                value, _newPassword.text),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(height: 45),
                        SizedBox(
                          width: double.infinity,
                          child: PillButtonFilled(
                            text: "Update",
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                            onPressed: () {
                              if (((_formKey.currentState as FormState)
                                      .validate()) ==
                                  true) {
                                _changePassword(
                                    _oldPassword.text, _newPassword.text);
                                context.pushNamed(homeScreenName, params: {
                                  pageParameterKey: profileScreenName
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
