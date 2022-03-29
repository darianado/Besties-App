import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog_textfield.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class BioField extends StatefulWidget {
  final bool editable;
  final String label;

  BioField({Key? key, required this.label, this.editable = false}) : super(key: key);

  @override
  State<BioField> createState() => _BioFieldState();
}

class _BioFieldState extends State<BioField> {
  late final FirestoreService _firestoreService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firestoreService = Provider.of<FirestoreService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.editable) {
      return ShakeAnimatedWidget(
        duration: const Duration(milliseconds: 200),
        shakeAngle: Rotation.deg(z: 0.6),
        child: bio(context, getOnTap(context)),
      );
    } else {
      return bio(context, getOnTap(context));
    }
  }

  Widget bio(BuildContext context, Function? onTap) {
    return Material(
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: InkWell(
        onTap: (onTap != null) ? (() => onTap()) : (null),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: tertiaryColour.withOpacity(0.1),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }

  Function? getOnTap(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    if (!widget.editable) return null;

    return () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditDialogTextField(value: _userState.user?.userData?.bio ?? " ", onSave: saveBio);
        });
  }

  Future<void> saveBio(String? userId, String? bio) async {
    if (userId != null && bio != null) {
      await _firestoreService.setBio(userId, bio.trim());
    }
  }
}
