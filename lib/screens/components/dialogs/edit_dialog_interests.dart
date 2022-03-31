import 'package:flutter/material.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/screens/components/interests/select_interests.dart';
import 'package:project_seg/screens/components/validation_error.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';

/// A widget that displays a dialog for when users want to edit their interests.
class EditDialogInterests extends StatefulWidget {
  final CategorizedInterests interests;
  final Function(CategorizedInterests) onSave;

  const EditDialogInterests({
    Key? key,
    required this.interests,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditDialogInterests> createState() => _EditDialogInterestsState();
}

class _EditDialogInterestsState extends State<EditDialogInterests> {
  late CategorizedInterests interests;
  String? validateInterestsError;

  @override
  void initState() {
    super.initState();
    interests = widget.interests;
  }

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

  /// Updates the [selected] interests.
  void _changeSelection(CategorizedInterests selected) {
    setState(() {
      interests = selected;
    });
  }

  /// Saves the newly selected interests.
  void _save() {
    Navigator.of(context).pop();
    widget.onSave(interests);
  }

  /// Validates the selection of interests a user has made.
  ///
  /// It checks if the user selected at least one interest, but no more than 10.
  bool validate() {
    final _contextState = Provider.of<ContextState>(context, listen: false);

    setState(() {
      validateInterestsError = validateInterests(
          widget.interests,
          _contextState.context?.minInterestsSelected,
          _contextState.context?.maxInterestsSelected);
    });

    return (validateInterestsError == null);
  }
}
