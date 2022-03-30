import 'package:flutter/material.dart';
import 'package:project_seg/constants/borders.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/screens/components/chip_widget.dart';

/**
 * This class represents the model of a reusable widget that is used
 * to display the main categories. Users can select a category
 * they are interested in.
 */

class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key? key,
      required this.category,
      required this.selected,
      required this.onTap})
      : super(key: key);

  final Category category;
  final Category selected;
  final Function onTap;

  /**
   * This method build a widget that is is used to display all the categories
   * grouped by title.
   * Users can select a category title in order to have displayed all the interests
   * that are part of that category.
   */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: circularBorderRadius15,
          color: lightTertiaryColour,
          child: InkWell(
            onTap: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          category.title,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const Icon(Icons.arrow_downward),
                    ],
                  ),
                  (selected.interests.isNotEmpty)
                      ? const SizedBox(
                          height: 20,
                        )
                      : Container(),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: selected.interests
                              .map((e) => ChipWidget(
                                    color: tertiaryColour,
                                    label: e.title,
                                    bordered: false,
                                    textColor: simpleWhiteColour,
                                    mini: true,
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
