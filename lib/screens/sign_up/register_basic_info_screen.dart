import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/validation_error.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:project_seg/utility/helpers.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
import '../../constants/borders.dart';

/// A widget that displays a sign up form for the user's basic information.
///
/// The user is asked to provide details such as first name, last name
/// birthday, gender and their relationship status.
class RegisterBasicInfoScreen extends StatefulWidget {
  final UserData userData;

  const RegisterBasicInfoScreen({Key? key, required this.userData}) : super(key: key);

  @override
  _RegisterBasicInfoScreenState createState() => _RegisterBasicInfoScreenState();
}

class _RegisterBasicInfoScreenState extends State<RegisterBasicInfoScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  String? validateDOBerror;
  String? validateGenderError;
  String? validateRelationshipStatusError;

  @override
  void dispose() {
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserState _userState = Provider.of<UserState>(context);
    ContextState _contextState = Provider.of<ContextState>(context);

    final _firstNameText = widget.userData.firstName;
    if (_firstNameText != null) {
      _firstName.text = _firstNameText;
    }

    final _lastNameText = widget.userData.lastName;
    if (_lastNameText != null) {
      _lastName.text = _lastNameText;
    }

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
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: simpleWhiteColour,
              expandedHeight: 120,
              collapsedHeight: 100,
              actions: [
                IconButton(
                  onPressed: () => _userState.signOut(),
                  icon: const Icon(FontAwesomeIcons.signOutAlt, color: primaryColour),
                ),
              ],
              flexibleSpace: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(leftRightPadding, 5, leftRightPadding, 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Let\'s start with the basics...',
                          style: Theme.of(context).textTheme.headline4?.apply(color: secondaryColour, fontWeightDelta: 2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(leftRightPadding),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: circularBorderRadius10,
                          color: lightTertiaryColour,
                        ),
                        child: TextFormField(
                          controller: _firstName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'First name',
                          ),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) => validateNotEmpty(value, "First name"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: circularBorderRadius10,
                          color: lightTertiaryColour,
                        ),
                        child: TextFormField(
                          controller: _lastName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Last name',
                          ),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) => validateNotEmpty(value, "Last name"),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Text(
                            'BIRTHDAY',
                            style: Theme.of(context).textTheme.bodyLarge?.apply(fontWeightDelta: 1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      DateOfBirthButton(
                        editable: true,
                        shouldExpand: true,
                        color: secondaryColour,
                        label: (widget.userData.dob != null) ? "${widget.userData.humanReadableDateOfBirth}" : "Select a date",
                        onSave: (dateTime) => setState(() {
                          widget.userData.dob = dateTime;
                        }),
                      ),
                      ValidationError(errorText: validateDOBerror),
                      const SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            'GENDER',
                            style: Theme.of(context).textTheme.bodyLarge?.apply(fontWeightDelta: 1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        key: const Key("genderRow"),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _contextState.context?.genders?.map((gender) {
                              return ChipWidget(
                                color: indigoColour,
                                bordered: widget.userData.gender == gender ? false : true,
                                textColor: (widget.userData.gender == gender) ? simpleWhiteColour : null,
                                iconColor: (widget.userData.gender == gender) ? simpleWhiteColour : null,
                                icon: getIconForGender(gender),
                                label: gender,
                                mini: true,
                                onTap: () => setState(() {
                                  widget.userData.gender = gender;
                                }),
                              );
                            }).toList() ??
                            [],
                      ),
                      ValidationError(errorText: validateGenderError),
                      const SizedBox(height: 25),
                      Row(
                        children: <Widget>[
                          Text(
                            'RELATIONSHIP STATUS',
                            style: Theme.of(context).textTheme.bodyLarge?.apply(fontWeightDelta: 1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RelationshipStatusButton(
                        editable: true,
                        shouldExpand: true,
                        label: (widget.userData.relationshipStatus != null) ? widget.userData.relationshipStatus! : "Click to select",
                        onSave: (relationshipStatus) => setState(() {
                          widget.userData.relationshipStatus = relationshipStatus;
                        }),
                      ),
                      ValidationError(errorText: validateRelationshipStatusError),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: PillButtonFilled(
                          text: "Next",
                          textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                          onPressed: () {
                            setState(() {
                              widget.userData.firstName = _firstName.text.trim();
                              widget.userData.lastName = _lastName.text.trim();
                            });

                            if (!_key.currentState!.validate() || !validate()) return;
                            context.goNamed(registerPhotoScreenName, extra: widget.userData);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Validates the user's selections.
  bool validate() {
    setState(() {
      validateDOBerror = validateDOB(widget.userData.dob);
      validateGenderError = validateGender(widget.userData.gender);
      validateRelationshipStatusError = validateRelationshipStatus(widget.userData.relationshipStatus);
    });

    return (validateDOBerror == null && validateGenderError == null && validateRelationshipStatusError == null);
  }
}
