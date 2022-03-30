import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/dialogs/dismiss_dialog.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/utility/auth_exception_handler.dart';
import 'package:project_seg/services/auth_service.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';


/**
 * This class represents the model of a reusable widget that is used
 * to display a dialog when users want to delete their account.
 */

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({Key? key}) : super(key: key);

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  final TextEditingController _password = TextEditingController();
  /**
   * This method builds an EditDialog widget that is invoked when users
   * show interest into deleteing their account.
   * In order to perform this action, users are required to confirm their password,
   * followed by pressing the "Delete" button. They can also exit the dialog by
   * pressing "Cancel"
   */

  @override
  Widget build(BuildContext context) {
    return EditDialog(
      confirmButtonText: 'Delete',
      confirmButtonColour: const Color(0xFFE74a33),
      onSave: () {
        if (((_formKey.currentState as FormState).validate()) == true) {
          _deleteUser(_password.text);
        }
      },
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Text(
                'Delete account',
                style: Theme.of(context).textTheme.headline4?.apply(fontWeightDelta: 2),
              ),
              const SizedBox(height: 5),
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
              Text(
                'Are you sure you want to leave us? \n All your details will be deleted!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  /**
   * This asyncronous method deletes the account to be removed from the database.
   * @param String - the password confirmation.
   */

  _deleteUser(String password) async {
    try {
      await Provider.of<UserState>(context).deleteAccount(password);
    } on FirebaseAuthException catch (e) {
      final errorMessage = AuthExceptionHandler.generateExceptionMessageFromException(e);
      showDialog(
        context: context,
        builder: (context) => DismissDialog(message: errorMessage),
      );
    }
  }
}
