import 'package:flutter/material.dart';

//simple method to show alert

   void showAlert(BuildContext context, String errorMsg) {
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              child: const Text("Back to Home Page"),
              onPressed: () {
                Navigator.pushNamed(context, '/landing');
              },
            ),
          ],
        );
      },
    );
  }
