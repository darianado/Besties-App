import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_dropdown.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:provider/provider.dart';

/// A widget that displays information about the user's university.
///
/// The [UniversityButton] is [editable] and can be [wiggling].
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

  /// Displays an [EditDialogDropdown] when the widget is tapped if it's editable.
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
