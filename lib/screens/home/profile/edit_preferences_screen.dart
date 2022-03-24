import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/gender_implementation.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/widget/icon_content.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:provider/provider.dart';
import '../../../constants/colours.dart';
import '../../../services/user_state.dart';
import '../../components/widget/display_interests.dart';

class EditPreferencesScreen extends StatefulWidget {
  @override
  State<EditPreferencesScreen> createState() => _EditPreferencesScreenState();
}

class _EditPreferencesScreenState extends State<EditPreferencesScreen> {
  Gender selectedGender = Gender.other;

  RangeValues _currentAgeRangeValues = const RangeValues(16, 30);

  Preferences? newPreferences;

  int difference(int? n1, int? n2) {
    return (n1 != null && n2 != null) ? n2 - n1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final _contextState = Provider.of<ContextState>(context);
    final _userState = Provider.of<UserState>(context);

    const spaceBetween = 40.0;
    const spaceBetweenWidgetAndTitle = 10.0;

    newPreferences ??= Preferences.fromMap(
        _userState.user?.userData?.preferences?.toMap() ?? {});

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.4, 0.8, 1],
        colors: [
          kWhiteColour,
          kWhiteColourShade2,
          kWhiteColourShade3,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(leftRightPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Edit preferences',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.apply(fontWeightDelta: 2),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Who are you looking for?',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: spaceBetween),
                  Row(
                    children: [
                      Text(
                        "Age",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: RangeValues(
                        newPreferences?.minAge?.toDouble() ?? 16,
                        newPreferences?.maxAge?.toDouble() ?? 100),
                    activeColor: kTertiaryColour,
                    inactiveColor: kGreyColour,
                    min: (_contextState.context?.minAge?.toDouble() ?? 16),
                    max: (_contextState.context?.maxAge?.toDouble() ?? 100),
                    divisions: difference(_contextState.context?.minAge,
                        _contextState.context?.maxAge),
                    labels: RangeLabels(
                      newPreferences?.minAge?.toString() ?? "16",
                      newPreferences?.maxAge?.toString() ?? "100",
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        newPreferences?.maxAge = values.end.toInt();
                        newPreferences?.minAge = values.start.toInt();
                      });
                    },
                  ),
                  const SizedBox(height: spaceBetween),
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
                  Row(
                    children: [
                      Text(
                        "Sexual orientation",
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                  /*
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
                    */
                  SizedBox(height: spaceBetweenWidgetAndTitle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _contextState.context?.genders?.map((gender) {
                          return ChipWidget(
                            color: kIndigoColour,
                            bordered: ((newPreferences?.genders != null) &&
                                    (newPreferences?.genders?.indexWhere((e) =>
                                            e?.toLowerCase() ==
                                            gender.toLowerCase()) !=
                                        -1))
                                ? false
                                : true,
                            textColor: ((newPreferences?.genders != null) &&
                                    (newPreferences?.genders?.indexWhere((e) =>
                                            e?.toLowerCase() ==
                                            gender.toLowerCase()) !=
                                        -1))
                                ? kSimpleWhiteColour
                                : null,
                            iconColor: ((newPreferences?.genders != null) &&
                                    (newPreferences?.genders?.indexWhere((e) =>
                                            e?.toLowerCase() ==
                                            gender.toLowerCase()) !=
                                        -1))
                                ? kSimpleWhiteColour
                                : null,
                            icon: getIconForGender(gender),
                            label: gender,
                            mini: true,
                            onTap: () => setState(() {
                              if ((newPreferences?.genders != null) &&
                                  (newPreferences?.genders?.indexWhere((e) =>
                                          e?.toLowerCase() ==
                                          gender.toLowerCase()) !=
                                      -1)) {
                                newPreferences?.genders?.removeWhere((e) =>
                                    e?.toLowerCase() == gender.toLowerCase());
                              } else {
                                newPreferences?.genders?.add(gender);
                              }
                            }),
                          );
                        }).toList() ??
                        [],
                  ),
                  const SizedBox(height: spaceBetween),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Interests",
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.apply(fontWeightDelta: 2),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spaceBetweenWidgetAndTitle),
                  DisplayInterests(
                    editable: true,
                    items: newPreferences?.interests?.flattenedInterests ?? [],
                    onSave: (newCategorizedInterests) {
                      setState(() {
                        newPreferences?.interests = newCategorizedInterests;
                      });
                    },
                  ),
                  const SizedBox(height: spaceBetween),
                  PillButtonFilled(
                    text: "Save information",
                    backgroundColor: kSecondaryColour,
                    expandsWidth: true,
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kWhiteColour),
                    onPressed: () {
                      FirestoreService.instance.setPreferences(
                          _userState.user!.user!.uid, newPreferences!);

                      context.goNamed(
                        homeScreenName,
                        params: {pageParameterKey: feedScreenName},
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  PillButtonOutlined(
                    text: "Cancel",
                    color: kSecondaryColour,
                    expandsWidth: true,
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kSecondaryColour),
                    onPressed: () => context.goNamed(
                      homeScreenName,
                      params: {pageParameterKey: feedScreenName},
                    ),
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
