import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class EditDialogDropdown extends StatefulWidget {
  final List<String> items;
  String? value;
  final Function(String?) onSave;

  EditDialogDropdown({Key? key, required this.items, value, required this.onSave})
      : value = safelyGetValue(items, value),
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
  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton(
              isExpanded: true,
              items: widget.items
                  .map(
                    (str) => DropdownMenuItem(
                      value: str,
                      child: Text(
                        str,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
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
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Color(0xFF0A1128),
                      side: BorderSide(color: Colors.grey, width: 1),
                      fixedSize: const Size(100, 30),
                     // shadowColor: Color(0xFF0083A1),
                      //elevation: 4,
                      textStyle: const TextStyle(
                        fontSize: 17,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kTertiaryColour,
                      fixedSize: const Size(100, 30),
                     // shadowColor: Color(0xFF0083A1),
                      //elevation: 4,
                      textStyle: const TextStyle(
                        fontSize: 17,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
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
