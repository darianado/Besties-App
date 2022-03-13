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

class DateOfBirthButton extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService.instance;
  final bool editable;

  DateOfBirthButton({
    Key? key,
    this.editable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editable) {
      return ShakeAnimatedWidget(
        duration: Duration(milliseconds: 200),
        shakeAngle: Rotation.deg(z: 1.5),
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
      color: Colors.green,
      icon: FontAwesomeIcons.birthdayCake,
      label: "${_userState.user?.userData?.age}",
      onTap: getOnTap(context),
    );
  }

  Function? getOnTap(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final _contextState = Provider.of<ContextState>(context);

    if (!editable) return null;

    final _uid = _userState.user?.user?.uid;
    final _dob = _userState.user?.userData?.dob;

    return () async => _selectDate(context, _uid, _dob);
  }

  void _selectDate(BuildContext context, String? uid, DateTime? dob) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    saveSelection(uid, picked);
  }

  Future<void> saveSelection(String? userId, DateTime? dateOfBirth) async {
    if (userId != null && dateOfBirth != null) {
      await _firestoreService.setDateOfBirth(userId, dateOfBirth);
    }
  }
}
