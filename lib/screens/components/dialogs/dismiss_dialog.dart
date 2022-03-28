import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';

class DismissDialog extends StatelessWidget {
  final String errorMessage;

  const DismissDialog({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            leftRightPadding, 20, leftRightPadding, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.topRight,
              child: PillButtonFilled(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Dismiss',
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.apply(color: whiteColour),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
