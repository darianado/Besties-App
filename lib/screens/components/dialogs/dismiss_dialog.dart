import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';

/**
 * This class represents a model of a reusable widget that is used
 * to display a dismiss dialog.
 */

class DismissDialog extends StatelessWidget {
  final String message;

  const DismissDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  /**
   * This method builds a DismissDialog widget that is invoked when
   * a certain action generates an error.
   */

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            leftRightPadding, 20, leftRightPadding, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 15),
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
