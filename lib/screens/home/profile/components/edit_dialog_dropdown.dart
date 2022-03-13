import 'package:flutter/material.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class EditDialogDropdown extends StatefulWidget {
  final List<String> items;
  String? value;
  final Function(String?, String?) onSave;

  EditDialogDropdown({Key? key, required this.items, value, required this.onSave})
      : value = safelyGetValue(items, value),
        super(key: key);

  static String? safelyGetValue(List<String> items, String? proposedValue) {
    if (proposedValue != null && items.contains(proposedValue)) return proposedValue;
    return null;
  }

  @override
  State<EditDialogDropdown> createState() => _EditDialogDropdownState();
}

class _EditDialogDropdownState extends State<EditDialogDropdown> {
  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton(
              isExpanded: true,
              items: widget.items
                  .map(
                    (str) => DropdownMenuItem(
                      value: str,
                      child: Text(str),
                    ),
                  )
                  .toList(),
              onChanged: (String? value) => changeSelection(value),
              value: widget.value,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await widget.onSave(_userState.user?.user?.uid, widget.value);
                    },
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
