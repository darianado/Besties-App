import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/category.dart';
import 'package:project_seg/models/interest.dart';
import 'package:project_seg/screens/home/profile/components/chip_widget.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:go_router/go_router.dart';

class SelectInterests extends StatefulWidget {
  SelectInterests({Key? key, required this.initialCategories, required this.onChange}) : super(key: key);

  List<Category> initialCategories;
  final Function(List<Category>) onChange;

  @override
  State<SelectInterests> createState() => _SelectInterestsState();
}

class _SelectInterestsState extends State<SelectInterests> {
  final FirestoreService _firestoreService = FirestoreService.instance;
  late Future<List<Category>>? possibleCategories;

  @override
  void initState() {
    super.initState();
    possibleCategories = _firestoreService.fetchInterests();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: possibleCategories,
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        List<Category>? possibleCategories = snapshot.data;

        if (possibleCategories == null) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }

        //categories.first.interests.first.selected = true;

        widget.initialCategories = syncCategories(widget.initialCategories, possibleCategories);

        return Column(
          children: [
            Column(
              children: widget.initialCategories.map((category) {
                return CategoryView(
                  category: category,
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return EditInterestBottomSheet(
                            category: category,
                            onChange: (newCategory) {
                              setState(() {
                                category = newCategory;
                              });

                              widget.onChange(widget.initialCategories);
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

  List<Category> syncCategories(List<Category> sync, List<Category> fetchedCategories) {
    fetchedCategories.forEach((category) {
      final _oldCategoryIndex = sync.indexWhere((element) => element.catId == category.catId);

      if (_oldCategoryIndex != -1) {
        category.interests.forEach((interest) {
          final _oldInterestIndex = sync.elementAt(_oldCategoryIndex).interests.indexWhere((element) => element.title == interest.title);

          if (_oldInterestIndex != -1) {
            //print("Setting selected for ${interest.title}, based on cat: ${_oldCategoryIndex} and interest: ${_oldInterestIndex}");
            interest.selected = sync.elementAt(_oldCategoryIndex).interests.elementAt(_oldInterestIndex).selected;
          }
        });
      }
    });

    return fetchedCategories;
  }
}

class EditInterestBottomSheet extends StatefulWidget {
  EditInterestBottomSheet({Key? key, required this.category, required this.onChange}) : super(key: key);

  Category category;
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
                          if (interest.selected) {
                            return ChipWidget(
                              color: kTertiaryColour,
                              label: interest.title,
                              bordered: false,
                              textColor: Colors.white,
                              mini: true,
                              onTap: () {
                                setState(() {
                                  interest.selected = false;
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
                                  interest.selected = true;
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

                        widget.onChange(widget.category);
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

  List<Interest> selected() {
    return widget.category.interests.where((element) => !element.selected).toList();
  }
}

class CategoryView extends StatelessWidget {
  CategoryView({Key? key, required this.category, required this.onTap}) : super(key: key);

  Category category;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        width: double.infinity,
        child: Material(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(15),
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
                    (selected().isNotEmpty)
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
                            children: selected()
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

  List<Interest> selected() {
    return category.interests.where((element) => element.selected).toList();
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