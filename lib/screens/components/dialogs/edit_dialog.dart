import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';

class EditDialog extends StatelessWidget {
  final Widget content;
  final Function onSave;

  const EditDialog({
    Key? key,
    required this.content,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
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
                  color: kTertiaryColour.withOpacity(0.1),
                ),
                child: content,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PillButtonOutlined(
                      text: "Cancel",
                      color: kTertiaryColour,
                      padding: EdgeInsets.symmetric(vertical: 7),
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: PillButtonFilled(
                      text: "Save",
                      padding: EdgeInsets.symmetric(vertical: 7),
                      backgroundColor: kTertiaryColour,
                      textStyle: Theme.of(context).textTheme.titleLarge?.apply(color: kWhiteColour),
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
