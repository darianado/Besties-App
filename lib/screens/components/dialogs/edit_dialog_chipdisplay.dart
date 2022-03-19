import 'package:flutter/material.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/components/widget/select_interests.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class EditDialogChipDisplay extends StatefulWidget {
  //final CategorizedInterests items;
  CategorizedInterests? values;
  final Function(CategorizedInterests?) onSave;

  EditDialogChipDisplay(
      {Key? key, /*required this.items,*/ values, required this.onSave})
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
            SelectInterests(
              onChange: (newCategories) {
                setState(() {
                  //widget.values = newCategories;
                });
              },
              selected: _userState.user?.userData?.categorizedInterests ??
                  CategorizedInterests(categories: []),
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
                      await widget.onSave(widget.values);
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

  void changeSelection(CategorizedInterests? selected) {
    if (selected != null) {
      setState(() {
        widget.values = selected;
      });
    }
  }
}
