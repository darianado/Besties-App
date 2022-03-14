import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

enum Cat { SELF_CARE, FOOD, SOCIAL_ACTIVITIES, SCIENCEandTECHNOLOGY, GAMES, SPORTS, ARTandLITERATURE, POPULARCULTURE }

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
    Category(id: Cat.SOCIAL_ACTIVITIES, name: "Travel"),
    Category(id: Cat.SOCIAL_ACTIVITIES, name: "Charity"),
    Category(id: Cat.SOCIAL_ACTIVITIES, name: "Dating"),
    Category(id: Cat.SOCIAL_ACTIVITIES, name: "Social media"),
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

  static List<Category> _scienceAndTechnology = [
    Category(id: Cat.SCIENCEandTECHNOLOGY, name: "Science and Technology"),
  ];

  static List<Category> _games = [
    Category(id: Cat.GAMES, name: "Video games"),
    Category(id: Cat.GAMES, name: "Carts"),
    Category(id: Cat.GAMES, name: "Board games"),
    Category(id: Cat.GAMES, name: "Card games"),
    Category(id: Cat.GAMES, name: "Poker"),
  ];

  static List<Category> _sports = [
    Category(id: Cat.SPORTS, name: "Outdoor activities"),
    Category(id: Cat.SPORTS, name: "Hiking"),
    Category(id: Cat.SPORTS, name: "Swimming"),
    Category(id: Cat.SPORTS, name: "Football"),
    Category(id: Cat.SPORTS, name: "Gym"),
    Category(id: Cat.SPORTS, name: "Tennis"),
    Category(id: Cat.SPORTS, name: "Volleyball"),
    Category(id: Cat.SPORTS, name: "Rugby"),
  ];

  static List<Category> _art_and_literature = [
    Category(id: Cat.ARTandLITERATURE, name: "Drawing"),
    Category(id: Cat.ARTandLITERATURE, name: "Painting"),
    Category(id: Cat.ARTandLITERATURE, name: "Poetry"),
    Category(id: Cat.ARTandLITERATURE, name: "Novels"),
    Category(id: Cat.ARTandLITERATURE, name: "Photography"),
    Category(id: Cat.ARTandLITERATURE, name: "Theatre"),
    Category(id: Cat.ARTandLITERATURE, name: "Opera"),
    Category(id: Cat.ARTandLITERATURE, name: "Musicals"),
    Category(id: Cat.ARTandLITERATURE, name: "Classical music"),
    Category(id: Cat.ARTandLITERATURE, name: "Jazz"),
  ];

  static List<Category> _popularCulture = [
    Category(id: Cat.GAMES, name: "Movies"),
    Category(id: Cat.GAMES, name: "TV Series"),
    Category(id: Cat.GAMES, name: "Reality shows"),
    Category(id: Cat.GAMES, name: "Music"),
  ];

  final _itemsSocialActivities =
      _socialActivities.map((social_activity) => MultiSelectItem<Category>(social_activity, social_activity.name)).toList();
  List<Category> _selectedSocialActivities = [];

  final _itemsFood = _food.map((food) => MultiSelectItem<Category>(food, food.name)).toList();
  List<Category> _selectedFood = [];

  final _itemsSelfCare = _selfCare.map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name)).toList();
  List<Category> _selectedSelfCare = [];

  final _itemsScienceAndTechnology = _scienceAndTechnology.map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name)).toList();
  List<Category> _selectedScienceAndTechnology = [];

  final _itemGames = _games.map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name)).toList();
  List<Category> _selectedGames = [];

  final _itemSports = _sports.map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name)).toList();
  List<Category> _selectedSports = [];

  final _itemArtAndLiterature = _art_and_literature.map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name)).toList();
  List<Category> _selectedArtAndLiterature = [];

  final _itemPopularCulture = _popularCulture.map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name)).toList();
  List<Category> _selectedPopularCulture = [];

  List<Category> _selectedItems = [];

  String dropdownValue = 'Select your interests';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: ExpansionTile(
          title: Text(dropdownValue),
          children: <Widget>[
            buildMultiSelectBottomSheetField(Cat.SOCIAL_ACTIVITIES, _itemsSocialActivities, _selectedSocialActivities),
            _selectedSocialActivities == null || _selectedSocialActivities.isEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "None selected",
                      style: TextStyle(color: Colors.black54),
                    ))
                : Container(),
            buildMultiSelectBottomSheetField(Cat.FOOD, _itemsFood, _selectedFood),
            _selectedFood == null || _selectedFood.isEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "None selected",
                      style: TextStyle(color: Colors.black54),
                    ))
                : Container(),
            buildMultiSelectBottomSheetField(Cat.SELF_CARE, _itemsSelfCare, _selectedSelfCare),
            _selectedSelfCare == null || _selectedSelfCare.isEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "None selected",
                      style: TextStyle(color: Colors.black54),
                    ))
                : Container(),
            buildMultiSelectBottomSheetField(Cat.SCIENCEandTECHNOLOGY, _itemsScienceAndTechnology, _selectedScienceAndTechnology),
            _selectedScienceAndTechnology == null || _selectedScienceAndTechnology.isEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "None selected",
                      style: TextStyle(color: Colors.black54),
                    ))
                : Container(),
            buildMultiSelectBottomSheetField(Cat.GAMES, _itemGames, _selectedGames),
            _selectedGames == null || _selectedGames.isEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "None selected",
                      style: TextStyle(color: Colors.black54),
                    ))
                : Container(),
            buildMultiSelectBottomSheetField(Cat.SPORTS, _itemSports, _selectedSports),
            _selectedSports == null || _selectedSports.isEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "None selected",
                      style: TextStyle(color: Colors.black54),
                    ))
                : Container(),
            buildMultiSelectBottomSheetField(Cat.ARTandLITERATURE, _itemArtAndLiterature, _selectedArtAndLiterature),
            _selectedArtAndLiterature == null || _selectedArtAndLiterature.isEmpty
                ? Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "None selected",
                      style: TextStyle(color: Colors.black54),
                    ))
                : Container(),
            buildMultiSelectBottomSheetField(Cat.POPULARCULTURE, _itemPopularCulture, _selectedPopularCulture),
            _selectedPopularCulture == null || _selectedPopularCulture.isEmpty
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

  MultiSelectBottomSheetField<Object?> buildMultiSelectBottomSheetField(
      Cat cat,
      //String name = describeEnum(cat);
      List<MultiSelectItem<Category>> listOfItems,
      List<Category> selectedItems) {
    return MultiSelectBottomSheetField(
        initialChildSize: 0.4,
        listType: MultiSelectListType.CHIP,
        searchable: true,
        buttonText: Text("Favorite " + getName(cat)),
        title: Text(describeEnum(cat)),
        items: listOfItems,
        onConfirm: (values) {
          setState(() {
            switch (cat) {
              case Cat.SELF_CARE:
                List<Category> items = [];
                if (!(values == null || values.isEmpty)) {
                  items = values.map((e) => Category(name: (e as Category).name, id: cat)).toList();
                }
                _selectedSelfCare = items;
                break;
              case Cat.FOOD:
                List<Category> items = [];
                if (!(values == null || values.isEmpty)) {
                  items = values.map((e) => Category(name: (e as Category).name, id: cat)).toList();
                }
                _selectedFood = items;
                break;
              case Cat.SOCIAL_ACTIVITIES:
                List<Category> items = [];
                if (!(values == null || values.isEmpty)) {
                  items = values.map((e) => Category(name: (e as Category).name, id: cat)).toList();
                }
                _selectedSocialActivities = items;
                break;
              case Cat.SCIENCEandTECHNOLOGY:
                List<Category> items = [];
                if (!(values == null || values.isEmpty)) {
                  items = values.map((e) => Category(name: (e as Category).name, id: cat)).toList();
                }
                _selectedScienceAndTechnology = items;
                break;
              case Cat.GAMES:
                List<Category> items = [];
                if (!(values == null || values.isEmpty)) {
                  items = values.map((e) => Category(name: (e as Category).name, id: cat)).toList();
                }
                _selectedGames = items;
                break;
              case Cat.SPORTS:
                List<Category> items = [];
                if (!(values == null || values.isEmpty)) {
                  items = values.map((e) => Category(name: (e as Category).name, id: cat)).toList();
                }
                _selectedSports = items;
                break;
              case Cat.ARTandLITERATURE:
                List<Category> items = [];
                if (!(values == null || values.isEmpty)) {
                  items = values.map((e) => Category(name: (e as Category).name, id: cat)).toList();
                }
                _selectedArtAndLiterature = items;
                break;
              case Cat.POPULARCULTURE:
                List<Category> items = [];
                if (!(values == null || values.isEmpty)) {
                  items = values.map((e) => Category(name: (e as Category).name, id: cat)).toList();
                }
                _selectedPopularCulture = items;
                break;
            }
          });
        },
        chipDisplay: MultiSelectChipDisplay(
          onTap: (value) {
            setState(() {
              switch ((value as Category).id) {
                case Cat.SELF_CARE:
                  _selectedSelfCare.remove(value);
                  break;
                case Cat.FOOD:
                  _selectedFood.remove(value);
                  break;
                case Cat.SOCIAL_ACTIVITIES:
                  _selectedSocialActivities.remove(value);
                  break;
                case Cat.SCIENCEandTECHNOLOGY:
                  _selectedScienceAndTechnology.remove(value);
                  break;
                case Cat.GAMES:
                  _selectedGames.remove(value);
                  break;
                case Cat.SPORTS:
                  _selectedSports.remove(value);
                  break;
                case Cat.ARTandLITERATURE:
                  _selectedArtAndLiterature.remove(value);
                  break;
                case Cat.POPULARCULTURE:
                  _selectedPopularCulture.remove(value);
                  break;
              }

              // _selectedItems = [
              //   _selectedSocialActivities,
              //   _selectedFood,
              //   _selectedSelfCare,
              //   _selectedScienceAndTechnology,
              //   _selectedGames,
              //   _selectedSports,
              //   _selectedArtAndLiterature,
              //   _selectedPopularCulture
              // ].expand((x) => x).toList();
              //
              // print(_selectedItems);
            });
          },
        ));
  }

  String getName(Cat cat) {
    switch (cat) {
      case Cat.SELF_CARE:
        return "Self care";
      case Cat.FOOD:
        return "Food";
      case Cat.SOCIAL_ACTIVITIES:
        return "Social activieties";
      case Cat.SCIENCEandTECHNOLOGY:
        return "Science and technology";
      case Cat.GAMES:
        return "Games";
      case Cat.SPORTS:
        return "Sprots";
      case Cat.ARTandLITERATURE:
        return "Art and literature";
      case Cat.POPULARCULTURE:
        return "Popular culture";
    }
  }
}
