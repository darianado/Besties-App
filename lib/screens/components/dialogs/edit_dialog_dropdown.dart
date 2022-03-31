import 'package:flutter/material.dart';
import 'package:project_seg/screens/components/dialogs/edit_dialog.dart';

/**
 * This class represents a model of a reusable widget that is used
 * to display a dialog dropdown when users want to edit information on their
 * profiles such as the university, gender or relationship status.
 */

class EditDialogDropdown extends StatefulWidget {
  final List<String> items;
  final String? initialValue;
  final Function(String?) onSave;

  EditDialogDropdown(
      {Key? key, required this.items, value, required this.onSave})
      : initialValue = safelyGetValue(items, value),
        super(key: key);

  /**
   * This method checks if the value selected by a user is in the list of possible values.
   * @param List<String> items - the list of values from which the user can select
   * the wanted item.
   * @param String? proposedValue - the value that the user selected
   *
   * @return the value the user selected,
   * if the user did not select a valid value, it returns the first element
   * in the list, otherwise null
   */

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
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  /**
   * This method builds an EditDialog widget that is invoked when users
   * want to edit information that is displayed on their own profiles.
   * The Dropdown Button is used to display lists for universities and
   * relationship status.
   * Once users select their options, they will be saved.
   */

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

  /**
   * This method allows users to change the selections made before.
   * @param String? selected - the item that users wish to select
   */
  void changeSelection(String? selected) {
    if (selected != null) {
      setState(() {
        _selectedValue = selected;
      });
    }
  }
}
