import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';





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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                  "It is time to choose categories you are interested in.",
                   textAlign: TextAlign.center,
              ),
              Text(
                "Please select at least one interest.",
                textAlign: TextAlign.center,
              ),
              Text(
                "The maximum number of categories you can select is 10",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
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
      ),
    );
  }
}

enum Cat {
  SELF_CARE,
  FOOD,
  SOCIAL_ACTIVITIES,
  SCIENCEandTECHNOLOGY,
  GAMES,
  SPORTS,
  ARTandLITERATURE,
  POPULARCULTURE
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

  final _itemsScienceAndTechnology = _scienceAndTechnology
      .map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name))
      .toList();
  List<Category> _selectedScienceAndTechnology = [];

  final _itemGames = _games
      .map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name))
      .toList();
  List<Category> _selectedGames = [];

  final _itemSports = _sports
      .map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name))
      .toList();
  List<Category> _selectedSports = [];

  final _itemArtAndLiterature = _art_and_literature
      .map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name))
      .toList();
  List<Category> _selectedArtAndLiterature = [];

  final _itemPopularCulture = _popularCulture
      .map((selfCare) => MultiSelectItem<Category>(selfCare, selfCare.name))
      .toList();
  List<Category> _selectedPopularCulture = [];


  String dropdownValue = 'Select your  interests';
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

          buildMultiSelectBottomSheetField("Science and Technology", _itemsScienceAndTechnology, _selectedScienceAndTechnology),
          buildMultiSelectBottomSheetField("Games", _itemGames, _selectedGames),
          buildMultiSelectBottomSheetField("Sport", _itemSports, _selectedSports),
          buildMultiSelectBottomSheetField("Art&Literature", _itemArtAndLiterature, _selectedArtAndLiterature),
          buildMultiSelectBottomSheetField("Sport", _itemPopularCulture, _selectedPopularCulture),
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
        case Cat.SCIENCEandTECHNOLOGY:
          _selectedScienceAndTechnology = values as List<Category>;
          break;
        case Cat.GAMES:
          _selectedGames = values as List<Category>;
          break;
        case Cat.SPORTS:
          _selectedSports = values as List<Category>;
          break;
        case Cat.ARTandLITERATURE:
          _selectedArtAndLiterature = values as List<Category>;
          break;
        case Cat.POPULARCULTURE:
          _selectedPopularCulture = values as List<Category>;
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
            });
          },
        )
      );
  }
}
