import 'package:flutter/material.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/**
 * This class represents a model of a reusable widget that is used
 * to display an edit dialog when users want to edit the bio on their profiles.
 */

class EditDialogTextField extends StatefulWidget {
  final String value;
  final Function(String?, String) onSave;

  const EditDialogTextField(
      {Key? key, required this.value, required this.onSave})
      : super(key: key);

  @override
  State<EditDialogTextField> createState() => _EditDialogTextFieldState();
}

class _EditDialogTextFieldState extends State<EditDialogTextField> {
  final TextEditingController _textFieldController = TextEditingController();

  /**
   * This method builds an EditDialog widget that is invoked when users
   * want to edit their bio.
   * Once changes are made, they will be saved.
   */

  @override
  Widget build(BuildContext context) {
    final _contextState = Provider.of<ContextState>(context);
    final _userState = Provider.of<UserState>(context);

    _textFieldController.text = widget.value;

    return EditDialog(
      content: TextField(
        controller: _textFieldController,
        minLines: 1,
        maxLength: _contextState.context?.maxBioLength ?? 200,
        maxLines: 10,
        decoration: const InputDecoration(border: InputBorder.none),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      onSave: () {
        Navigator.of(context).pop();
        widget.onSave(_userState.user?.user?.uid, _textFieldController.text);
      },
    );
  }
}
