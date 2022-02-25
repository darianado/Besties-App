import 'package:flutter/material.dart';

//simple alert dialog widget

class AlertPopup extends StatelessWidget {
  const AlertPopup  ({ Key? key , required this.message}) : super(key: key);
  final String message ; 
  @override
  Widget build(BuildContext context) {
           return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              child: const Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
  }
}