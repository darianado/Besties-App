import 'package:flutter/material.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/screens/components/validation_error.dart';
import 'package:project_seg/screens/components/interests/select_interests.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
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
  String? validateInterestsError;

  @override
  Widget build(BuildContext context) {
    return EditDialog(
      content: Column(
        children: [
          SelectInterests(
            onChange: _changeSelection,
            selected: widget.interests,
          ),
          ValidationError(errorText: validateInterestsError),
        ],
      ),
      onSave: () {
        if (!validate()) return;
        _save();
      },
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

  bool validate() {
    final _contextState = Provider.of<ContextState>(context, listen: false);

    setState(() {
      validateInterestsError =
          validateInterests(widget.interests, _contextState.context?.minInterestsSelected, _contextState.context?.maxInterestsSelected);
    });

    return (validateInterestsError == null);
  }
}
