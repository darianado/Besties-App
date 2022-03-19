import 'package:flutter/material.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class EditDialogChipDisplay extends StatefulWidget {
  final List<Interest> items;
  List<Interest>? values;
  final Function(List<Interest>?) onSave;

  EditDialogChipDisplay(
      {Key? key, required this.items, values, required this.onSave})
      : values = /*safelyGetValue(items, value)*/ values == null
            ? values
            : null,
        super(key: key);

  /*static String? safelyGetValue(List<String> items, String? proposedValue) {
    if (proposedValue != null && items.contains(proposedValue)) return proposedValue;
    if (items.isNotEmpty) return items.first;
    return null;
  }*/

  @override
  State<EditDialogChipDisplay> createState() => _EditDialogChipDisplayState();
}

class _EditDialogChipDisplayState extends State<EditDialogChipDisplay> {
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
                      await widget.onSave(widget.value);
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
