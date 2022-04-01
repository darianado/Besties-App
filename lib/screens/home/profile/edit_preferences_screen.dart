import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/interests/display_interests.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/utility/helpers.dart';
import 'package:provider/provider.dart';
import '../../../constants/colours.dart';
import '../../../states/user_state.dart';

/// A widget that allows the user to change the preferences regarding the people their looking for.
class EditPreferencesScreen extends StatefulWidget {
  const EditPreferencesScreen({Key? key}) : super(key: key);

  @override
  State<EditPreferencesScreen> createState() => _EditPreferencesScreenState();
}

class _EditPreferencesScreenState extends State<EditPreferencesScreen> {
  late final FirestoreService _firestoreService;
  Preferences? newPreferences;
  bool isLoading = false;

  /// Save the new [preferences] to the database.
  Future<void> save(String userID, Preferences preferences) async {
    setState(() {
      isLoading = true;
    });

    await _firestoreService.setPreferences(userID, preferences);
  }

  @override
  void initState() {
    super.initState();
    _firestoreService = Provider.of<FirestoreService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final _contextState = Provider.of<ContextState>(context);
    final _userState = Provider.of<UserState>(context);

    const spaceBetween = 40.0;
    const spaceBetweenWidgetAndTitle = 10.0;

    newPreferences ??= Preferences.fromMap(_userState.user?.userData?.preferences?.toMap() ?? {});

    final limitMinAge = _contextState.context?.minAge?.toDouble() ?? 16.0;
    final limitMaxAge = _contextState.context?.maxAge?.toDouble() ?? 50.0;

    final preferredMinAge = newPreferences?.minAge?.toDouble() ?? 16.0;
    final preferredMaxAge = newPreferences?.maxAge?.toDouble() ?? 50.0;

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
                    style: Theme.of(context).textTheme.headline4?.apply(fontWeightDelta: 2),
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
                        style: Theme.of(context).textTheme.headline6?.apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                  RangeSlider(
                    values: RangeValues(preferredMinAge, preferredMaxAge),
                    activeColor: tertiaryColour,
                    inactiveColor: greyColour,
                    min: limitMinAge,
                    max: limitMaxAge,
                    divisions: difference(limitMinAge, limitMaxAge).toInt(),
                    labels: RangeLabels(
                      "${preferredMinAge.toInt()}",
                      "${preferredMaxAge.toInt()}",
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        newPreferences?.maxAge = values.end.toInt();
                        newPreferences?.minAge = values.start.toInt();
                      });
                    },
                  ),
                  Text(
                    'Age: ${preferredMinAge.toInt()} - ${preferredMaxAge.toInt()}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: spaceBetween),
                  Row(
                    children: [
                      Text(
                        "Gender",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline6?.apply(fontWeightDelta: 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: spaceBetweenWidgetAndTitle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _contextState.context?.genders?.map((gender) {
                          return ChipWidget(
                            color: indigoColour,
                            bordered: ((newPreferences?.genders != null) &&
                                    (newPreferences?.genders?.indexWhere((e) => e?.toLowerCase() == gender.toLowerCase()) != -1))
                                ? false
                                : true,
                            textColor: ((newPreferences?.genders != null) &&
                                    (newPreferences?.genders?.indexWhere((e) => e?.toLowerCase() == gender.toLowerCase()) != -1))
                                ? simpleWhiteColour
                                : null,
                            iconColor: ((newPreferences?.genders != null) &&
                                    (newPreferences?.genders?.indexWhere((e) => e?.toLowerCase() == gender.toLowerCase()) != -1))
                                ? simpleWhiteColour
                                : null,
                            icon: getIconForGender(gender),
                            label: gender,
                            mini: true,
                            onTap: () => setState(() {
                              if ((newPreferences?.genders != null) &&
                                  (newPreferences?.genders?.indexWhere((e) => e?.toLowerCase() == gender.toLowerCase()) != -1)) {
                                newPreferences?.genders?.removeWhere((e) => e?.toLowerCase() == gender.toLowerCase());
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
                          style: Theme.of(context).textTheme.headline6?.apply(fontWeightDelta: 2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: spaceBetweenWidgetAndTitle),
                  DisplayInterests(
                    editable: true,
                    interests: newPreferences?.interests ?? CategorizedInterests(categories: []),
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
                    isLoading: isLoading,
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    onPressed: () async {
                      await save(_userState.user!.user!.uid, newPreferences!);

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
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: secondaryColour),
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
