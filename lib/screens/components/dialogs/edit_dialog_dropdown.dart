import 'package:flutter/material.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';

class EditDialogDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final Function(String?) onSave;

  EditDialogDropdown({Key? key, required this.items, value, required this.onSave})
      : initialValue = safelyGetValue(items, value),
        super(key: key);

  static String? safelyGetValue(List<String> items, String? proposedValue) {
    if (proposedValue != null && items.contains(proposedValue)) return proposedValue;
    if (items.isNotEmpty) return items.first;
    return null;
  }

  @override
  State<EditDialogDropdown> createState() => _EditDialogDropdownState();
}

class _EditDialogDropdownState extends State<EditDialogDropdown> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
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
          value: _selectedValue),
      onSave: () {
        Navigator.of(context).pop();
        widget.onSave(_selectedValue);
      },
    );
  }

  void changeSelection(String? selected) {
    if (selected != null) {
      setState(() {
        _selectedValue = selected;
      });
    }
  }
}
