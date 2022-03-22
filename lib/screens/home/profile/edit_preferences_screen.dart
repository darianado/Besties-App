
import 'package:flutter/material.dart';
import 'package:project_seg/models/gender_implementation.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../constants/colours.dart';
import '../../../constants/textStyles.dart';
import '../../../services/user_state.dart';
import '../../components/widget/display_interests.dart';

class EditPreferencesScreen extends StatefulWidget {
  @override
  _EditPreferencesScreenState createState() => _EditPreferencesScreenState();
}

class _EditPreferencesScreenState extends State<EditPreferencesScreen> {
  final GlobalKey _key = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  Gender selectedGender = Gender.other;
  RangeValues _currentAgeRangeValues = const RangeValues(16, 30);
  RangeValues _currentDistanceRangeValues = const RangeValues(16, 30);
  bool isMaleChecked = true;
  bool isFemaleChecked = true;
  bool isOtherChecked = true;


  @override
  void dispose() {
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _gender.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Edit your preferences'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: Text('Edit your preferences',
                      style: kTitlePreferencesStyle,
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: const [
                    SizedBox(width: 20),
                    Text(
                      "Age",
                      textAlign: TextAlign.left,
                      style: kBoldStyle,
                    ),
                  ],
                ),
                RangeSlider(
                  values: _currentAgeRangeValues,
                  activeColor: kTertiaryColour ,
                  inactiveColor: kGreyColour,
                  min: 16,
                  max: 30,
                  divisions: 15,
                  labels: RangeLabels(
                    _currentAgeRangeValues.start.round().toString(),
                    _currentAgeRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentAgeRangeValues = values;
                    });
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                // Row(
                //   children: const [
                //     SizedBox(width: 20),
                //     Text(
                //       "Distance",
                //       textAlign: TextAlign.left,
                //       style: kBoldStyle,
                //     ),
                //   ],
                // ),
                // RangeSlider(
                //   values: _currentDistanceRangeValues,
                //   min: 16,
                //   max: 30,
                //   divisions: 15,
                //   labels: RangeLabels(
                //     _currentDistanceRangeValues.start.round().toString(),
                //     _currentDistanceRangeValues.end.round().toString(),
                //   ),
                //   onChanged: (RangeValues values) {
                //     setState(() {
                //       _currentDistanceRangeValues = values;
                //     });
                //   },
                // ),
                const SizedBox(height: 20),
                Row(
                  children: const [
                    SizedBox(width: 20),
                    Text(
                      "Select the gender you are interested in",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildCheckBox(Gender.male, isMaleChecked),
                    const Text("Male"),
                    const SizedBox(width: 20),
                    buildCheckBox(Gender.female, isFemaleChecked),
                    const Text("Female"),
                    const SizedBox(width: 20),
                    buildCheckBox(Gender.other, isOtherChecked),
                    const Text("Other"),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: const [
                    SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        "Select interests you would want to learn about from other people",
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                DisplayInterests(
                  items: _userState.user?.userData?.flattenedInterests ?? [],
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => context.goNamed("home", params: {'page': 'profile'}),
                  child: const Text("SAVE NEW INFORMATION"),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  //Able to select more than one gender to be interested in
  Checkbox buildCheckBox(@required Gender gender, bool isChecked) {
    return Checkbox(
      checkColor: kSimpleWhiteColour,
      activeColor: kTertiaryColour,
      //fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          switch (gender) {
            case Gender.male:
              isMaleChecked = !isMaleChecked;
              break;
            case Gender.female:
              isFemaleChecked = !isFemaleChecked;
              break;
            case Gender.other:
              isOtherChecked = !isOtherChecked;
          }
        });
      },
    );
  }
}
