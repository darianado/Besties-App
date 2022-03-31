import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_dropdown.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/// A widget that is used to display the user's gender.
///
/// The [GenderButton] is [editable] and can be [wiggling].
class GenderButton extends StatelessWidget {
  final bool editable;
  final bool wiggling;
  final bool shouldExpand;
  final String label;
  final Color color;
  final Function(String?)? onSave;

  const GenderButton({
    Key? key,
    this.editable = false,
    this.wiggling = false,
    this.shouldExpand = false,
    required this.label,
    this.color = Colors.indigo,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editable) {
      return ShakeAnimatedWidget(
        duration: const Duration(milliseconds: 200),
        shakeAngle: Rotation.deg(z: 4),
        child: chip(context),
      );
    } else {
      return chip(context);
    }
  }

  /// This method generates icons depanding on gender.
  /// @ param String? - the gender to be selected
  /// @return the IconData corresponding to the selected gender

  IconData getIconForGender(String? gender) {
    switch (gender?.toLowerCase()) {
      case "male":
        return FontAwesomeIcons.mars;
      case "female":
        return FontAwesomeIcons.venus;
      default:
        return FontAwesomeIcons.venusMars;
    }
  }

  Widget chip(BuildContext context) {
    return ChipWidget(
      color: color,
      shouldExpand: shouldExpand,
      icon: getIconForGender(label),
      onTap: getOnTap(context),
    );
  }

  /// Displays an [EditDialogDropdown] when the widget is tapped if it's editable.
  Function? getOnTap(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final _contextState = Provider.of<ContextState>(context);

    final _onSave = onSave;

    if (!editable || (_onSave == null)) return null;

    return () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditDialogDropdown(
              items: _contextState.context?.genders ?? [],
              value: _userState.user?.userData?.gender,
              onSave: _onSave,
            );
          },
        );
  }
}
