import 'package:flutter/material.dart';
import 'package:project_seg/constants/borders.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/screens/components/chip_widget.dart';

class CategoryView extends StatelessWidget {
  CategoryView({Key? key, required this.category, required this.selected, required this.onTap}) : super(key: key);

  Category category;
  Category selected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        width: double.infinity,
        child: Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: circularBorderRadius15,
          color: lightTertiaryColour,
          child: InkWell(
            onTap: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            category.title,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Icon(Icons.arrow_downward),
                      ],
                    ),
                    (selected.interests.isNotEmpty)
                        ? SizedBox(
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
      ),
    );
  }
}
