import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_chipdisplay.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';

import '../dialogs/edit_dialog_dropdown.dart';

class DisplayInterests extends StatelessWidget {
  const DisplayInterests({
    Key? key,
    required this.items,
    this.editable = false,
    this.wiggling = false,
    this.mini = true,
    this.onSave,
  }) : super(key: key);

  final List<Interest> items;
  final bool wiggling;
  final bool editable;
  final bool mini;
  final Function(CategorizedInterests?)? onSave;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final _contextState = Provider.of<ContextState>(context);

    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: items.map((interest) {
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

  Widget chip(String label, BuildContext context) {
    return ChipWidget(
      color: kTertiaryColour,
      bordered: false,
      label: label,
      capitalizeLabel: true,
      mini: mini,
      textColor: Colors.white,
      onTap: getOnTap(label, context),
    );
  }

  Function? getOnTap(String label, BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final _contextState = Provider.of<ContextState>(context);

    final _onSave = onSave;

    if (!editable || (_onSave == null)) return null;

    return () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditDialogChipDisplay(
              //items: _userState.user?.userData?.categorizedInterests ?? CategorizedInterests(categories: []),
              values: _userState.user?.userData?.categorizedInterests ?? CategorizedInterests(categories: []),
              onSave: _onSave,
            );
          },
        );
  }
}
