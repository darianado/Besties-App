import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/chip_widget.dart';

/// A widget to edit the selection of interests made by users.
///
/// All interests are grouped by categories.
class EditInterestBottomSheet extends StatefulWidget {
  final Category category;
  final Category selected;
  final Function(Category) onChange;

  const EditInterestBottomSheet(
      {Key? key,
      required this.category,
      required this.selected,
      required this.onChange})
      : super(key: key);

  @override
  State<EditInterestBottomSheet> createState() =>
      _EditInterestBottomSheetState();
}

class _EditInterestBottomSheetState extends State<EditInterestBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.category.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.apply(fontWeightDelta: 2)),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: widget.category.interests.map((interest) {
                        if (isInBoth(interest, widget.category.interests,
                            widget.selected.interests)) {
                          return ChipWidget(
                            color: tertiaryColour,
                            label: interest.title,
                            bordered: false,
                            textColor: simpleWhiteColour,
                            mini: true,
                            onTap: () {
                              setState(() {
                                widget.selected.interests.removeWhere(
                                    (element) =>
                                        element.title == interest.title);
                              });
                            },
                          );
                        } else {
                          return ChipWidget(
                            color: tertiaryColour,
                            label: interest.title,
                            bordered: true,
                            mini: true,
                            onTap: () {
                              setState(() {
                                widget.selected.interests.add(interest);
                              });
                            },
                          );
                        }
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: PillButtonFilled(
                    text: "Save",
                    backgroundColor: secondaryColour,
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: whiteColour),
                    onPressed: () {
                      Navigator.of(context).pop();

                      widget.onChange(widget.selected);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /// Checks whether a specified value is in both lists of interests.
  bool isInBoth(
      Interest interest, List<Interest> first, List<Interest> second) {
    return first
            .where((element) =>
                element.title.toLowerCase() == interest.title.toLowerCase())
            .isNotEmpty &&
        second
            .where((element) =>
                element.title.toLowerCase() == interest.title.toLowerCase())
            .isNotEmpty;
  }
}
