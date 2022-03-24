import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/widget/icon_content.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';

import '../../constants/borders.dart';

class RegisterBasicInfoScreen extends StatefulWidget {
  RegisterBasicInfoScreen({Key? key, required this.userData}) : super(key: key);

  UserData userData;

  @override
  _RegisterBasicInfoScreenState createState() => _RegisterBasicInfoScreenState();
}

class _RegisterBasicInfoScreenState extends State<RegisterBasicInfoScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  bool couldNotValidateDOB = false;
  bool couldNotValidateGender = false;
  bool couldNotValidateRelationshipStatus = false;

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
            kWhiteColour,
            kWhiteColourShade2,
            kWhiteColourShade3,
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
              backgroundColor: kSimpleWhiteColour,
              expandedHeight: 120,
              collapsedHeight: 100,
              actions: [
                IconButton(
                  onPressed: () => _userState.signOut(),
                  icon: buildIcons(FontAwesomeIcons.signOutAlt, kPrimaryColour),
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
                          style: Theme.of(context).textTheme.headline4?.apply(color: kSecondaryColour, fontWeightDelta: 2),
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
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: circularBorderRadius10,
                          color: kLightTertiaryColour,
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
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: circularBorderRadius10,
                          color: kLightTertiaryColour,
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
                      SizedBox(height: 40),
                      Row(
                        children: [
                          Text(
                            'BIRTHDAY',
                            style: Theme.of(context).textTheme.bodyLarge?.apply(fontWeightDelta: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      DateOfBirthButton(
                        editable: true,
                        shouldExpand: true,
                        color: kSecondaryColour,
                        label: (widget.userData.dob != null) ? "${widget.userData.humanReadableDateOfBirth}" : "Select a date",
                        onSave: (dateTime) => setState(() {
                          widget.userData.dob = dateTime;
                        }),
                      ),
                      (couldNotValidateDOB)
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    "You must fill in this field",
                                    style: Theme.of(context).textTheme.bodySmall?.apply(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            'GENDER',
                            style: Theme.of(context).textTheme.bodyLarge?.apply(fontWeightDelta: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _contextState.context?.genders?.map((gender) {
                                return ChipWidget(
                                  color: kIndigoColour,
                                  bordered: widget.userData.gender == gender ? false : true,
                                  textColor: (widget.userData.gender == gender) ? kSimpleWhiteColour : null,
                                  iconColor: (widget.userData.gender == gender) ? kSimpleWhiteColour : null,
                                  icon: getIconForGender(gender),
                                  label: gender,
                                  mini: true,
                                  onTap: () => setState(() {
                                    widget.userData.gender = gender;
                                  }),
                                );
                              }).toList() ??
                              []),
                      (couldNotValidateGender)
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    "You must fill in this field",
                                    style: Theme.of(context).textTheme.bodySmall?.apply(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'RELATIONSHIP STATUS',
                            style: Theme.of(context).textTheme.bodyLarge?.apply(fontWeightDelta: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      RelationshipStatusButton(
                        editable: true,
                        shouldExpand: true,
                        label: (widget.userData.relationshipStatus != null) ? widget.userData.relationshipStatus! : "Click to select",
                        onSave: (relationshipStatus) => setState(() {
                          widget.userData.relationshipStatus = relationshipStatus;
                        }),
                      ),
                      (couldNotValidateRelationshipStatus)
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    "You must fill in this field",
                                    style: Theme.of(context).textTheme.bodySmall?.apply(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        child: PillButtonFilled(
                          text: "Next",
                          backgroundColor: kTertiaryColour,
                          textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: kWhiteColour),
                          onPressed: () {
                            if (!_key.currentState!.validate()) return;

                            if (widget.userData.dob == null) {
                              setState(() {
                                couldNotValidateDOB = true;
                              });
                              return;
                            }
                            couldNotValidateDOB = false;

                            if (widget.userData.gender == null) {
                              setState(() {
                                couldNotValidateGender = true;
                              });
                              return;
                            }
                            couldNotValidateGender = false;

                            if (widget.userData.relationshipStatus == null) {
                              setState(() {
                                couldNotValidateRelationshipStatus = true;
                              });
                              return;
                            }
                            couldNotValidateRelationshipStatus = false;

                            setState(() {
                              widget.userData.firstName = _firstName.text.trim();
                              widget.userData.lastName = _lastName.text.trim();
                            });

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
}
