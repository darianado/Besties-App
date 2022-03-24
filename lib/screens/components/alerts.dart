import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//simple method to show alert

void showAlert(BuildContext context, String errorMsg) {
  //alerts to display errors to user
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(errorMsg),
        actions: [
          TextButton(
            child: const Text("Dismiss"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showEmailAlert(BuildContext context, String message) {
  //alerts to notify users to check their email before proceeding
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            child: const Text("Back to Home Page"),
            onPressed: () {
              context.goNamed("login");
            },
          ),
        ],
      );
    },
  );
}

showCalendarAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Age restriction"),
    content: Text("You have to be over 16 to use this app"),
    actions: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text("Go back to complete the profile"),
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
