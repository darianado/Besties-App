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

class RelationshipStatusButton extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService.instance;
  final bool editable;

  RelationshipStatusButton({
    Key? key,
    this.editable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (editable) {
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
      color: Colors.red.shade400,
      icon: FontAwesomeIcons.heart,
      label: _userState.user?.userData?.relationshipStatus ?? "-",
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
              items: _contextState.context?.relationshipStatuses ?? [],
              value: _userState.user?.userData?.relationshipStatus,
              onSave: saveSelection,
            );
          },
        );
  }

  Future<void> saveSelection(String? userId, String? relationshipStatus) async {
    if (userId != null && relationshipStatus != null) {
      await _firestoreService.setRelationshipStatus(userId, relationshipStatus);
    }
  }
}
