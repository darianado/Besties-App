import 'package:flutter/material.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/screens/components/widget/select_interests.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class EditDialogInterests extends StatefulWidget {
  CategorizedInterests interests;
  final Function(CategorizedInterests) onSave;

  EditDialogInterests({
    Key? key,
    required this.interests,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditDialogInterests> createState() => _EditDialogInterestsState();
}

class _EditDialogInterestsState extends State<EditDialogInterests> {
  @override
  Widget build(BuildContext context) {
    return EditDialog(
      content: SelectInterests(
        onChange: _changeSelection,
        selected: widget.interests,
      ),
      onSave: _save,
    );
  }

  void _changeSelection(CategorizedInterests selected) {
    if (selected != null) {
      setState(() {
        widget.interests = selected;
      });
    }
  }

  void _save() {
    Navigator.of(context).pop();
    widget.onSave(widget.interests);
  }
}
