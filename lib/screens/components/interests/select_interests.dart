import 'package:flutter/material.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/screens/components/interests/category_view.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/interests/edit_interests_bottom_sheet.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/constants/colours.dart';
import '../../../constants/borders.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';

class SelectInterests extends StatefulWidget {
  SelectInterests({
    Key? key,
    required this.selected,
    required this.onChange,
  }) : super(key: key);

  CategorizedInterests selected;
  final Function(CategorizedInterests) onChange;

  @override
  State<SelectInterests> createState() => _SelectInterestsState();
}

class _SelectInterestsState extends State<SelectInterests> {
  final FirestoreService _firestoreService = FirestoreService.instance;
  late Future<CategorizedInterests>? possibleCategories;

  @override
  void initState() {
    super.initState();
    possibleCategories = _firestoreService.fetchInterests();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategorizedInterests>(
      future: possibleCategories,
      builder: (BuildContext context, AsyncSnapshot<CategorizedInterests> snapshot) {
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

        CategorizedInterests _filteredSelected = widget.selected.filter(_possible);
        _filteredSelected = _filteredSelected.addMissing(_possible);

        return Column(
          children: [
            Column(
              children: _possible.categories.map((Category category) {
                Category _selectedCategory = _filteredSelected.getCorrespondingCategory(category);

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
