import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';

/**
 * This class represents the model of a reusable widget that is used
 * to display a dialog when users want make edits on their profiles.
 */

class EditDialog extends StatelessWidget {
  final Widget content;
  final Function onSave;
  final String confirmButtonText;
  final Color confirmButtonTextColour;
  final Color confirmButtonColour;

  const EditDialog({
    Key? key,
    required this.content,
    required this.onSave,
    this.confirmButtonText = 'Save',
    this.confirmButtonTextColour = whiteColour,
    this.confirmButtonColour = tertiaryColour,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: tertiaryColour.withOpacity(0.1),
                ),
                child: content,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PillButtonOutlined(
                      text: "Cancel",
                      color: tertiaryColour,
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PillButtonFilled(
                      text: confirmButtonText,
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      backgroundColor: confirmButtonColour,
                      textStyle: Theme.of(context).textTheme.titleLarge?.apply(color: confirmButtonTextColour),
                      onPressed: onSave,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
