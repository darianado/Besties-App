import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_interests.dart';

class DisplayInterests extends StatelessWidget {
  const DisplayInterests({
    Key? key,
    required this.interests,
    this.editable = false,
    this.wiggling = false,
    this.mini = true,
    this.onSave,
  }) : super(key: key);

  final CategorizedInterests interests;
  final bool wiggling;
  final bool editable;
  final bool mini;
  final Function(CategorizedInterests)? onSave;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: interests.flattenedInterests.map((interest) {
        if (wiggling) {
          return ShakeAnimatedWidget(
            duration: const Duration(milliseconds: 200),
            shakeAngle: Rotation.deg(z: 1.5),
            child: chip(interest.title, context),
          );
        } else {
          return chip(interest.title, context);
        }
      }).toList(),
    );
  }

  /**
   * This method returns a widget that displays the label in a chip.
   */

  Widget chip(String label, BuildContext context) {
    return ChipWidget(
      color: tertiaryColour,
      bordered: false,
      label: label,
      capitalizeLabel: true,
      mini: mini,
      textColor: whiteColour,
      onTap: getOnTap(label, context),
    );
  }

  /**
   * This method specifies action to be performed in the editable instances
   * of this button. It will trigger the onSave functionality.
   */

  Function? getOnTap(String label, BuildContext context) {
    final _onSave = onSave;

    if (!editable || (_onSave == null)) return null;

    return () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditDialogInterests(
              interests: interests,
              onSave: _onSave,
            );
          },
        );
  }
}
