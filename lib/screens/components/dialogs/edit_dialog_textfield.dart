import 'package:flutter/material.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/// A widget that displays an [EditDialog] that contains a [TextField].
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
