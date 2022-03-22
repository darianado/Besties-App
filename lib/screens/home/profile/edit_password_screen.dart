
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/services/auth_exception_handler.dart';
import 'package:project_seg/screens/components/alerts.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/constants/colours.dart';
import '../../../constants/borders.dart';
import '../../../constants/textStyles.dart';
import '../../components/widget/icon_content.dart';

class EditPasswordScreen extends StatefulWidget {
  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  final AuthService _authService = AuthService.instance;

  @override
  void dispose() {
    super.dispose();
    _oldPassword.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
  }

  _changePassword(String currentPassword, String newPassword) async {
    try {
      await _authService.changePassword(currentPassword, newPassword);
    } on FirebaseAuthException catch (e) {
      final errorMsg =
      AuthExceptionHandler.generateExceptionMessageFromException(e);
      showAlert(context, errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.4, 0.8, 1],
              colors: [
                kWhiteColour,
                kWhiteColourShade2,
                kWhiteColourShade3,
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
                    foregroundColor: kTertiaryColour,
                    backgroundColor: kWhiteColour,
                    expandedHeight: 10,
                    collapsedHeight: 80,
                    systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                    ),
                    leading: IconButton(
                      onPressed: () =>
                          context.pushNamed("home", params: {'page': 'profile'}),
                      icon: buildIcons(Icons.arrow_back_ios, kPrimaryColour),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Change your password',
                                style: kPasswordStyle,
                              ),
                              const SizedBox(height: 50),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: kCircularBorderRadius10,
                                  color: kTertiaryColour.withOpacity(0.1),
                                ),
                                child: TextFormField(
                                  controller: _oldPassword,
                                  obscureText: true,
                                  decoration:  InputDecoration(
                                      border: InputBorder.none,
                                      icon: buildIcons(Icons.lock, kSecondaryColour),
                                      labelText: 'Current password'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: kCircularBorderRadius10,
                                  color: kTertiaryColour.withOpacity(0.1),
                                ),
                                child: TextFormField(
                                  controller: _newPassword,
                                  obscureText: true,
                                  decoration:  InputDecoration(
                                      border: InputBorder.none,
                                      icon: buildIcons(Icons.lock, kSecondaryColour),
                                      labelText: 'New password'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if (value == _oldPassword.text) {
                                      return "Please enter a different password to old one.";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: kCircularBorderRadius10,
                                  color: kTertiaryColour.withOpacity(0.1),
                                ),
                                child: TextFormField(
                                  controller: _confirmNewPassword,
                                  obscureText: true,
                                  decoration:  InputDecoration(
                                      border: InputBorder.none,
                                      icon: buildIcons(Icons.lock, kSecondaryColour),
                                      labelText: 'Confirm new password'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    if (value != _newPassword.text) {
                                      return "Please type the same password";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                              const SizedBox(height: 45),
                              SizedBox(
                                width: double.infinity,
                                height: 0.07 * screenHeight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (((_formKey.currentState as FormState)
                                        .validate()) ==
                                        true) {
                                      _changePassword(
                                          _oldPassword.text, _newPassword.text);
                                      context.pushNamed("home",
                                          params: {'page': 'profile'});
                                    }
                                  },
                                  child: const Text("Update"),
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(kTertiaryColour),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                        const EdgeInsets.all(10.0)),
                                    textStyle: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.apply(fontWeightDelta: 2)),
                                    shape: MaterialStateProperty.all(kRoundedRectangulareBorder40),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
}
