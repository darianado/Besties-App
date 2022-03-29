import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_dropdown.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:provider/provider.dart';

/**
 * This class represents the model of a reusable widget that is used
 * to display the relationship related information for the users.
 * The Relationship Status button can be editable
 * depending on the place it is used. In the profile related screens
 * it displays the user's relationship status.
 */

class RelationshipStatusButton extends StatelessWidget {
  final bool editable;
  final bool wiggling;
  final bool shouldExpand;
  final String label;
  final Color color;
  final Function(String?)? onSave;

  const RelationshipStatusButton({
    Key? key,
    this.editable = false,
    this.wiggling = false,
    this.shouldExpand = false,
    required this.label,
    this.color = Colors.red,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (wiggling) {
      return ShakeAnimatedWidget(
        duration: const Duration(milliseconds: 200),
        shakeAngle: Rotation.deg(z: 1),
        child: chip(context),
      );
    } else {
      return chip(context);
    }
  }

  Widget chip(BuildContext context) {
    return ChipWidget(
      color: color,
      shouldExpand: shouldExpand,
      icon: FontAwesomeIcons.heart,
      label: label,
      onTap: getOnTap(context),
    );
  }

  /**
   * This method specifies action to be performed in the editable instances
   * of this button. It will trigger the onSave functionality.
   */

  Function? getOnTap(BuildContext context) {
    final _contextState = Provider.of<ContextState>(context);

    final _onSave = onSave;

    if (!editable || (_onSave == null)) return null;

    return () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditDialogDropdown(
              items: _contextState.context?.relationshipStatuses ?? [],
              value: label,
              onSave: _onSave,
            );
          },
        );
  }
}
