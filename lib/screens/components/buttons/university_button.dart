import 'package:animated_widgets/animated_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_dropdown.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class UniversityButton extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService.instance;
  final bool editable;
  final bool wiggling;
  final bool shouldExpand;
  final String label;
  final Color color;
  final Function(String?)? onSave;

  UniversityButton({
    Key? key,
    this.editable = false,
    this.wiggling = false,
    this.shouldExpand = false,
    required this.label,
    this.color = kTertiaryColour,
    this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (wiggling) {
      return ShakeAnimatedWidget(
        duration: Duration(milliseconds: 200),
        shakeAngle: Rotation.deg(z: 1),
        child: chip(context),
      );
    } else {
      return chip(context);
    }
  }

  Widget chip(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final _contextState = Provider.of<ContextState>(context);

    return ChipWidget(
      color: color,
      shouldExpand: shouldExpand,
      icon: FontAwesomeIcons.university,
      label: label,
      onTap: getOnTap(context),
    );
  }

  Function? getOnTap(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
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
