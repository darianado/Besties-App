import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/screens/home/profile/components/edit_dialog_textfield.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class BioField extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService.instance;
  final bool editable;

  BioField({Key? key, this.editable = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editable) {
      return ShakeAnimatedWidget(
        duration: Duration(milliseconds: 200),
        shakeAngle: Rotation.deg(z: 1),
        child: bio(context, getOnTap(context)),
      );
    } else {
      return bio(context, getOnTap(context));
    }
  }

  Widget bio(BuildContext context, Function? onTap) {
    final _userState = Provider.of<UserState>(context);

    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      child: InkWell(
        onTap: (onTap != null) ? (() => onTap()) : (null),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kTertiaryColour.withOpacity(0.1),
          ),
          child: Text(
            _userState.user?.userData?.bio ?? " ",
            style: TextStyle(
              fontSize: 18,
              color: kTertiaryColour,
            ),
          ),
        ),
      ),
    );
  }

  Function? getOnTap(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    if (!editable) return null;

    return () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditDialogTextField(value: _userState.user?.userData?.bio ?? " ", onSave: saveBio);
        });
  }

  Future<void> saveBio(String? userId, String? bio) async {
    if (userId != null && bio != null) {
      await _firestoreService.setBio(userId, bio);
    }
  }
}
