import 'package:flutter/material.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';


class EditDialogDropdown extends StatefulWidget {
  final List<String> items;
  String? value;
  final Function(String?) onSave;

  EditDialogDropdown(
      {Key? key, required this.items, value, required this.onSave})
      : value = safelyGetValue(items, value),
        super(key: key);

  static String? safelyGetValue(List<String> items, String? proposedValue) {
    if (proposedValue != null && items.contains(proposedValue))
      return proposedValue;
    if (items.isNotEmpty) return items.first;
    return null;
  }

  @override
  State<EditDialogDropdown> createState() => _EditDialogDropdownState();
}

class _EditDialogDropdownState extends State<EditDialogDropdown> {
  void _save() async {
    Navigator.of(context).pop();
    await widget.onSave(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return EditDialog(
      content: DropdownButton(
        isExpanded: true,
        underline: Container(),
        items: widget.items
            .map(
              (str) => DropdownMenuItem(
                value: str,
                child: Text(
                  str,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            )
            .toList(),
        onChanged: (String? value) => changeSelection(value),
        value: widget.value,
      ),
      onSave: () {
        Navigator.of(context).pop();
        widget.onSave(widget.value);
      },
    );
  }

  void changeSelection(String? selected) {
    if (selected != null) {
      setState(() {
        widget.value = selected;
      });
    }
  }
}
