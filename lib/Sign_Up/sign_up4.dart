import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'sign_up1.dart';





class SignUp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Sign up'),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: InterestStatus(),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

enum Cat {
  SELF_CARE, FOOD, SOCIAL_ACTIVITIES
}

class Category {
  final Cat id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });
}

class InterestStatus extends StatefulWidget {
  @override
  State<InterestStatus> createState() => _InterestStatusState();
}

class _InterestStatusState extends State<InterestStatus> {

  static List<Category> _socialActivities = [
    Category(id: Cat.SOCIAL_ACTIVITIES, name: "Clubbing"),
    Category(id:  Cat.SOCIAL_ACTIVITIES, name: "Travel"),
    Category(id:  Cat.SOCIAL_ACTIVITIES, name: "Charity"),
    Category(id:  Cat.SOCIAL_ACTIVITIES, name: "Dating"),
    Category(id:  Cat.SOCIAL_ACTIVITIES, name: "Social media"),
  ];

  static List<Category> _food = [
    Category(id: Cat.FOOD, name: "Food"),
  ];

  static List<Category> _selfCare = [
    Category(id: Cat.SELF_CARE, name: "Make-up"),
    Category(id: Cat.SELF_CARE, name: "Shopping"),
    Category(id: Cat.SELF_CARE, name: "Fashion"),
    Category(id: Cat.SELF_CARE, name: "Skin Routine"),
  ];



  final _itemsSocialActivities = _socialActivities
      .map((social_activity) => MultiSelectItem<Category>(social_activity, social_activity.name))
      .toList();
  List<Category> _selectedSocialActivities = [];

  final _itemsFood = _food
      .map((food) => MultiSelectItem<Category>(food, food.name))
      .toList();
  List<Category> _selectedFood = [];

  final _itemsSelfCare = _selfCare
      .map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name))
      .toList();
  List<Category> _selectedSelfCare = [];


  String dropdownValue = 'Select your first interest';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
      child: ExpansionTile(
        title: Text(dropdownValue),
        children: <Widget>[
          buildMultiSelectBottomSheetField("socialActivities", _itemsSocialActivities, _selectedSocialActivities),


          buildMultiSelectBottomSheetField("Food", _itemsFood, _selectedFood),

          buildMultiSelectBottomSheetField("Self care", _itemsSelfCare, _selectedSelfCare),
          _selectedSelfCare == null || _selectedSelfCare.isEmpty
              ? Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              child: Text(
                "None selected",
                style: TextStyle(color: Colors.black54),
              ))
              : Container(),

        ],
      ),
      ),
    );
  }

  MultiSelectBottomSheetField<Object?> buildMultiSelectBottomSheetField(String name, List<MultiSelectItem<Category>> listOfItems, List<Category> selectedItems) {
    return MultiSelectBottomSheetField(
        initialChildSize: 0.4,
        listType: MultiSelectListType.CHIP,
        searchable: true,
        buttonText: Text("Favorite $name"),
        title: Text(name),
        items: listOfItems,
        onConfirm: (values) {
    setState(() {
      switch ((values as Category).id) {
        case Cat.SELF_CARE:
          _selectedSelfCare.addAll((values as List<Category>));
          break;
        case Cat.FOOD:
          _selectedFood = values as List<Category>;
          break;
        case Cat.SOCIAL_ACTIVITIES:
          _selectedSocialActivities = values as List<Category>;
          break;
      }
    });
        },
        chipDisplay: MultiSelectChipDisplay(
          onTap: (value) {
            setState(() {
              switch((value as Category).id) {
                case Cat.SELF_CARE:
                  _selectedSelfCare.remove(value);
                  break;
                case Cat.FOOD:
                  _selectedFood.remove(value);
                  break;
                case Cat.SOCIAL_ACTIVITIES:
                  _selectedSocialActivities.remove(value);
                  break;
              }
            });
          },
        )
      );
  }
}
