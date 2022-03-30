import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_dropdown.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:provider/provider.dart';

/**
 * This class represents the model of a reusable widget that is used
 * to display the university the users attend to.
 * The University button can be editable in the Sign Up process and in Edit Profile screen,
 * but it cannot be edited when the current users sees information related to the others( in the partial
 * profile screen available on Feed or on other users' complete profile that is available after
 * a match occured)
 */

class UniversityButton extends StatelessWidget {
  final bool editable;
  final bool wiggling;
  final bool shouldExpand;
  final String label;
  final Color color;
  final Function(String?)? onSave;

  const UniversityButton({
    Key? key,
    this.editable = false,
    this.wiggling = false,
    this.shouldExpand = false,
    required this.label,
    this.color = tertiaryColour,
    this.onSave,
  }) : super(key: key);


  /**
   * The widget wiggles when it can be editable(in th Edit Profile Screen)
   */

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
      icon: FontAwesomeIcons.university,
      label: label,
      onTap: getOnTap(context),
    );
  }

  /**
   * This method allows users to tap on the button in the instances when it is ediatble.
   * If the button is not editable in that case, nothing will happen,
   * otherwise a DialogDropdown will be triggered so that users can select a new university
   * from a pre-defined list of universities in London.
   */

  Function? getOnTap(BuildContext context) {
    final _contextState = Provider.of<ContextState>(context);

    final _onSave = onSave;

    if (!editable || (_onSave == null)) return null;

    return () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditDialogDropdown(
              items: _contextState.context?.universities ?? [],
              value: label,
              onSave: _onSave,
            );
          },
        );
  }
}
