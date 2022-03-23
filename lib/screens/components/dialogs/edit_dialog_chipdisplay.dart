import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';
import 'package:project_seg/screens/components/widget/select_interests.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class EditDialogChipDisplay extends StatefulWidget {
  //final CategorizedInterests items;
  CategorizedInterests? values;
  final Function(CategorizedInterests?) onSave;

  EditDialogChipDisplay({Key? key, values, required this.onSave})
      : values = values == null ? values : null,
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
  void _save() async {
    Navigator.of(context).pop();
    await widget.onSave(widget.values);
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return EditDialog(
      content: SelectInterests(
        onChange: (newCategories) {
          setState(() {
            widget.values = newCategories;
          });
        },
        selected: _userState.user?.userData?.categorizedInterests ?? CategorizedInterests(categories: []),
      ),
      onSave: () {
        Navigator.of(context).pop();
        widget.onSave(widget.values);
      },
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
