import 'package:animated_widgets/animated_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/screens/home/profile/components/chip_widget.dart';
import 'package:project_seg/screens/home/profile/components/edit_dialog_dropdown.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class GenderButtton extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService.instance;
  final bool editable;

  GenderButtton({
    Key? key,
    this.editable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editable) {
      return ShakeAnimatedWidget(
        duration: Duration(milliseconds: 200),
        shakeAngle: Rotation.deg(z: 4),
        child: chip(context),
      );
    } else {
      return chip(context);
    }
  }

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
    final _userState = Provider.of<UserState>(context);
    final _contextState = Provider.of<ContextState>(context);

    return ChipWidget(
      color: Colors.indigo.shade500,
      icon: getIconForGender(_userState.user?.userData?.gender),
      onTap: getOnTap(context),
    );
  }

  Function? getOnTap(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final _contextState = Provider.of<ContextState>(context);

    if (!editable) return null;

    return () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditDialogDropdown(
              items: _contextState.context?.genders ?? [],
              value: _userState.user?.userData?.gender,
              onSave: saveSelection,
            );
          },
        );
  }

  Future<void> saveSelection(String? userId, String? gender) async {
    if (userId != null && gender != null) {
      await _firestoreService.setGender(userId, gender);
    }
  }
}
