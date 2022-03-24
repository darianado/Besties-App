import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';

import '../../constants/colours.dart';

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
    title: Text(
      "Age restriction",
      style:
      TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
      textAlign: TextAlign.center,
    ),
    content: Text(
        "You have to be over 16 in order to use this app.",
      style: Theme.of(context).textTheme.bodyText1,
    ),
    actions: [
      Center(
        child: PillButtonOutlined(
          text: "Go back to complete the profile",
          textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: secondaryColour,
          ),
          color: secondaryColour,
          onPressed: () {
            Navigator.of(context).pop();
            },
          )
        )
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        //   child: const Text(
        //       "Go back to complete the profile",
        //     textAlign: TextAlign.center,
        //   ),
        // ),

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
