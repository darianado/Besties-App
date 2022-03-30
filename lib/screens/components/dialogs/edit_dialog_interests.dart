import 'package:flutter/material.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/screens/components/interests/select_interests.dart';
import 'package:project_seg/screens/components/validation_error.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';

/**
 * This class represents the model of a reusable widget that is used
 * to display a dialog  when users want edit their interest preferences.
 */

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

  /**
   * This method builds an EditDialog widget that is invoked when users
   * want to edit information about the interests they selected.
   * Once users select their options, they will be saved.
   */

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

  /**
   * This method allows users to change the selections made before.
   * @param CategorizedInterests selected - the interest that
   * users wish to select
   */
  void _changeSelection(CategorizedInterests selected) {
    setState(() {
      interests = selected;
    });
  }

  /**
   * This method saves the new interests selected
   */

  void _save() {
    Navigator.of(context).pop();
    widget.onSave(interests);
  }

  /**
   * This method validates the selection of interests users made.
   * It checks if users selected at least one interest, but no more than 10.
   * @return True if the selection is valid, False otherwise
   */

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
