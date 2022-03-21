import 'package:flutter/material.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/Interests/category.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';

import '../../../constants/borders.dart';

class SelectInterests extends StatefulWidget {
  SelectInterests({Key? key, required this.selected, required this.onChange}) : super(key: key);

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
        CategorizedInterests? possible = snapshot.data;

        if (possible == null) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }

        //categories.first.interests.first.selected = true;

        //widget.initialCategories = syncCategories(widget.initialCategories, possibleCategories);

        widget.selected = retainPossible(widget.selected, possible);
        widget.selected = addMissingCategories(widget.selected, possible);

        return Column(
          children: [
            Column(
              children: possible.categories.map((category) {
                Category _selected = widget.selected.categories
                    .singleWhere((e) => e.title == category.title, orElse: () => Category(title: category.title, interests: []));

                return CategoryView(
                  category: category,
                  selected: _selected,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return EditInterestBottomSheet(
                            category: category,
                            selected: _selected,
                            onChange: (newCategory) {
                              print("Selected: ${newCategory.interests.map((e) => e.title)}");
                              setState(() {
                                _selected = newCategory;
                              });

                              widget.onChange(widget.selected);
                            },
                          );
                        });
                  },
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  CategorizedInterests retainPossible(CategorizedInterests categories, CategorizedInterests filter) {
    CategorizedInterests _localCategories = categories;

    _localCategories.categories.forEach((category) {
      int? _filterCategoryIndex = filter.categories.indexWhere((e) => e.title == category.title);

      if (_filterCategoryIndex == -1) {
        _localCategories.categories.remove(category);
      } else {
        category.interests.forEach((interest) {
          int _filterInterestIndex =
              filter.categories.elementAt(_filterCategoryIndex).interests.indexWhere((e) => e.title == interest.title);

          if (_filterInterestIndex == -1) category.interests.remove(interest);
        });
      }
    });

    return _localCategories;
  }

  CategorizedInterests addMissingCategories(CategorizedInterests categories, CategorizedInterests filter) {
    CategorizedInterests _localCategories = categories;

    filter.categories.forEach((category) {
      int _categoryIndex = categories.categories.indexWhere((e) => e.title == category.title);

      if (_categoryIndex == -1) {
        _localCategories.categories.add(Category(title: category.title, interests: []));
      }
    });

    return _localCategories;
  }
}

class EditInterestBottomSheet extends StatefulWidget {
  EditInterestBottomSheet({Key? key, required this.category, required this.selected, required this.onChange}) : super(key: key);

  Category category;
  Category selected;
  final Function(Category) onChange;

  @override
  State<EditInterestBottomSheet> createState() => _EditInterestBottomSheetState();
}

class _EditInterestBottomSheetState extends State<EditInterestBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.category.title,
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                child: Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: widget.category.interests.map((interest) {
                          if (isInBoth(interest, widget.category.interests, widget.selected.interests)) {
                            return ChipWidget(
                              color: kTertiaryColour,
                              label: interest.title,
                              bordered: false,
                              textColor: Colors.white,
                              mini: true,
                              onTap: () {
                                setState(() {
                                  widget.selected.interests.remove(interest);
                                });
                              },
                            );
                          } else {
                            return ChipWidget(
                              color: kTertiaryColour,
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
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();

                        widget.onChange(widget.selected);
                      },
                      child: Text("OK"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isInBoth(Interest interest, List<Interest> first, List<Interest> second) {
    return first.where((element) => element.title == interest.title).isNotEmpty &&
        second.where((element) => element.title == interest.title).isNotEmpty;
  }
}

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
          borderRadius: kCircularBorderRadius15,
          color: kLightTertiaryColour,
          child: InkWell(
            onTap: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          category.title,
                          style: TextStyle(fontSize: 20),
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
                                      color: kTertiaryColour,
                                      label: e.title,
                                      bordered: false,
                                      textColor: Colors.white,
                                      mini: true,
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    )
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

/*
class SelectInterests extends StatefulWidget {
  List<Category> categories;

  SelectInterests({required this.categories});

  @override
  State<SelectInterests> createState() => _SelectInterestsState();
}

class _SelectInterestsState extends State<SelectInterests> {
  @override
  Widget build(BuildContext context) {
    final FirestoreService _firestoreService = FirestoreService.instance;

    print("Rebuilding");

    return FutureBuilder(
      future: _firestoreService.fetchInterests(),
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        List<Category>? categories = snapshot.data;

        if (categories == null) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }

        //categories.first.interests.first.selected = true;

        categories = syncCategories(categories);

        //print("Selected after? ${widget.categories.first.interests.first.selected}");

        return Column(
          children: [
            Text(
                "Selected: ${widget.categories.map((category) => category.interests.where((interest) => interest.selected).map((e) => e.title))}"),
            ElevatedButton(
                onPressed: () => print(
                    widget.categories.map((category) => category.interests.where((interest) => interest.selected).map((e) => e.title))),
                child: Text("Check")),
            Column(
              children: categories.map((category) {
                return CategoryView(
                  category: category,
                  onChange: (values) => onChange(category, values),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }

  void onChange(Category category, List<Interest?> newValues) {
    final _categoryIndex = widget.categories.indexWhere((element) => element.catId == category.catId);

    if (_categoryIndex != -1) {
      widget.categories.elementAt(_categoryIndex).interests = List.from(newValues.where((element) => element != null));
    } else {
      widget.categories
          .add(Category(catId: category.catId, title: category.title, interests: List.from(newValues.where((element) => element != null))));
    }
  }

  List<Category> syncCategories(List<Category> fetchedCategories) {
    final _old = widget.categories;

    fetchedCategories.forEach((category) {
      final _oldCategoryIndex = _old.indexWhere((element) => element.catId == category.catId);

      if (_oldCategoryIndex != -1) {
        category.interests.forEach((interest) {
          final _oldInterestIndex = _old.elementAt(_oldCategoryIndex).interests.indexWhere((element) => element.title == interest.title);

          if (_oldInterestIndex != -1) {
            //print("Setting selected for ${interest?.title}, based on cat: ${_oldCategoryIndex} and interest: ${_oldInterestIndex}");
            interest.selected = _old.elementAt(_oldCategoryIndex).interests.elementAt(_oldInterestIndex).selected;
          }
        });
      }
    });

    return fetchedCategories;
  }
}

class CategoryView extends StatefulWidget {
  Category category;
  final Function(List<Interest?>) onChange;

  CategoryView({Key? key, required this.category, required this.onChange}) : super(key: key);

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Interest> selected() {
    return widget.category.interests.where((element) => element.selected).toList();
  }

  @override
  Widget build(BuildContext context) {
    /*
    final displayItems = selected.interests.map((interest) => MultiSelectItem(interest, (interest?.title ?? "?"))).toList();

    print("There are ${displayItems.length} items being shown");
    print("Initial value: ${selected.interests.length}");
    print("These are selected: ${selected.interests.map((e) => e?.title)}");
    */

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: kTertiaryColour.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                MultiSelectBottomSheetField<Interest?>(
                  buttonText: Text(
                    widget.category.title,
                    style: TextStyle(fontSize: 20),
                  ),
                  title: Text(
                    widget.category.title,
                    style: TextStyle(fontSize: 20),
                  ),
                  decoration:
                      (widget.category.interests.where((element) => element.selected).toList().length == 0) ? BoxDecoration() : null,
                  listType: MultiSelectListType.CHIP,
                  selectedColor: kTertiaryColour,
                  selectedItemsTextStyle: TextStyle(color: Colors.white),
                  items: widget.category.interests.map((interest) => MultiSelectItem(interest, (interest.title))).toList(),
                  initialValue: widget.category.interests.where((element) => element.selected).toList(),
                  onConfirm: (values) {
                    /*
                    setState(() {
                      widget.category.interests.forEach((element) {
                        element.selected = values.contains(element);
                      });
                    });
                    */

                    //widget.usersCategory.interests = widget.fullCategory.interests.where((interest) => values.contains(interest)).toList();

                    //print("These are selected: " + values.map((e) => e?.title ?? "-").toString());

                    widget.onChange(values);

                    /*
                    setState(() {
                      widget.category.interests.forEach((element) {
                        element.selected = values.contains(element);
                      });
                    });
                    */
                  },
                  /*
                  chipDisplay: MultiSelectChipDisplay(
                    chipColor: kTertiaryColour,
                    textStyle: TextStyle(color: Colors.white),
                    items: widget.category.interests
                        .where((element) => element.selected)
                        .toList()
                        .map((interest) => MultiSelectItem(interest, (interest.title)))
                        .toList(),
                    onTap: (interest) {
                      /*
                      /*
                      setState(() {
                        widget.category.interests
                            .where((element) => element.title == interest?.title)
                            .forEach((element) => element.selected = false);
                      });
                      */
                      //widget.onChanged(interest);

                      print("full category id: " + widget.fullCategory.catId);
                      print("user category id: " + (widget.usersCategory.catId));

                      /*
                      setState(() {
                        widget.usersCategory?.interests.removeWhere((element) => element.title == interest?.title);
                      });
                      */

                      //widget.usersCategory.interests.removeWhere((element) => element.title == interest?.title);

                      widget.onChange(widget.usersCategory);
                      */
                    },
                  ),
                  */
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/