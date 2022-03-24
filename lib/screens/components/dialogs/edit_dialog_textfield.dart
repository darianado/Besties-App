import 'package:flutter/material.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class EditDialogTextField extends StatefulWidget {
  String value;
  final Function(String?, String) onSave;

  EditDialogTextField({Key? key, required this.value, required this.onSave})
      : super(key: key);

  @override
  State<EditDialogTextField> createState() => _EditDialogTextFieldState();
}

class _EditDialogTextFieldState extends State<EditDialogTextField> {
  TextEditingController _textFieldController = TextEditingController();

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
        decoration: InputDecoration(border: InputBorder.none),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      onSave: () {
        Navigator.of(context).pop();
        widget.onSave(_userState.user?.user?.uid, _textFieldController.text);
      },
    );
  }
}
