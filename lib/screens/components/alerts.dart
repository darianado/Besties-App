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
