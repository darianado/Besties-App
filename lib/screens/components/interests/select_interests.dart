import 'package:flutter/material.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/screens/components/interests/category_view.dart';
import 'package:project_seg/screens/components/interests/edit_interests_bottom_sheet.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:provider/provider.dart';

/// A widget used to select interests.
class SelectInterests extends StatefulWidget {
  final CategorizedInterests selected;
  final Function(CategorizedInterests) onChange;

  const SelectInterests({
    Key? key,
    required this.selected,
    required this.onChange,
  }) : super(key: key);

  @override
  State<SelectInterests> createState() => _SelectInterestsState();
}

class _SelectInterestsState extends State<SelectInterests> {
  late Future<CategorizedInterests>? possibleCategories;

  @override
  void initState() {
    super.initState();
    possibleCategories =
        Provider.of<FirestoreService>(context, listen: false).fetchInterests();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategorizedInterests>(
      future: possibleCategories,
      builder:
          (BuildContext context, AsyncSnapshot<CategorizedInterests> snapshot) {
        CategorizedInterests? _possible = snapshot.data;

        if (_possible == null) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }

        CategorizedInterests _filteredSelected =
            widget.selected.filter(_possible);
        _filteredSelected = _filteredSelected.addMissing(_possible);

        return Column(
          children: [
            Column(
              children: _possible.categories.map((Category category) {
                Category _selectedCategory =
                    _filteredSelected.getCorrespondingCategory(category);

                return CategoryView(
                    category: category,
                    selected: _selectedCategory,
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return EditInterestBottomSheet(
                              category: category,
                              selected: _selectedCategory,
                              onChange: (newCategory) {
                                setState(() {
                                  _selectedCategory = newCategory;
                                });

                                widget.onChange(_filteredSelected);
                              },
                            );
                          });
                    });
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
