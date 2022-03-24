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
          whiteColour,
          whiteColourShade2,
          whiteColourShade3,
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
                  const SizedBox(height: 5),
                  Text(
                    'Who are you looking for?',
                    style: Theme.of(context).textTheme.titleLarge,
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
                    activeColor: tertiaryColour,
                    inactiveColor: greyColour,
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
                  Text(
                    'Age: ${newPreferences?.minAge} - ${newPreferences?.maxAge}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: spaceBetween),
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
                  SizedBox(height: spaceBetweenWidgetAndTitle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _contextState.context?.genders?.map((gender) {
                          return ChipWidget(
                            color: indigoColour,
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
                                ? simpleWhiteColour
                                : null,
                            iconColor: ((newPreferences?.genders != null) &&
                                    (newPreferences?.genders?.indexWhere((e) =>
                                            e?.toLowerCase() ==
                                            gender.toLowerCase()) !=
                                        -1))
                                ? simpleWhiteColour
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
                    backgroundColor: secondaryColour,
                    expandsWidth: true,
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: whiteColour),
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
                    color: secondaryColour,
                    expandsWidth: true,
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: secondaryColour),
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
