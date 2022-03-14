import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/home/profile/components/chip_widget.dart';
import 'package:project_seg/screens/home/profile/components/edit_dob_button.dart';
import 'package:project_seg/screens/home/profile/components/relationship_status_button.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

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

  @override
  void dispose() {
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserState _userState = Provider.of<UserState>(context);

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
            Color(0xFFFEFCFB),
            Color(0xFFE2F9FE),
            Color(0xFFD8F8FF),
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
              backgroundColor: Colors.white,
              expandedHeight: 150,
              collapsedHeight: 100,
              actions: [
                IconButton(
                  onPressed: () => _userState.signOut(),
                  icon: Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: kPrimaryColour,
                  ),
                ),
              ],
              flexibleSpace: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: Text(
                    'TELL US ABOUT YOURSELF',
                    style: TextStyle(
                      fontSize: 29.0,
                      fontWeight: FontWeight.bold,
                      color: kSecondaryColour,
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kLightTertiaryColour,
                        ),
                        child: TextFormField(
                          controller: _firstName,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'First name',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (content) {
                            if (content == null || content.isEmpty) return "First name is required";
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kLightTertiaryColour,
                        ),
                        child: TextFormField(
                            controller: _lastName,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Last name',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (content) {
                              if (content == null || content.isEmpty) return "Last name is required";
                            }),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          Text(
                            'BIRTHDAY',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColour.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DateOfBirthButton(
                        editable: true,
                        shouldExpand: true,
                        color: kSecondaryColour,
                        label: (widget.userData.dob != null) ? "${widget.userData.humanReadableDateOfBirth}" : "Select a date",
                        onSave: (dateTime) => setState(() {
                          widget.userData.dob = dateTime;
                        }),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Text(
                            'GENDER',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColour.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChipWidget(
                            color: Colors.indigo,
                            bordered: (widget.userData.gender == "Male") ? false : true,
                            textColor: (widget.userData.gender == "Male") ? Colors.white : null,
                            iconColor: (widget.userData.gender == "Male") ? Colors.white : null,
                            icon: FontAwesomeIcons.mars,
                            label: "Male",
                            onTap: () => setState(() {
                              widget.userData.gender = "Male";
                            }),
                          ),
                          ChipWidget(
                            color: Colors.indigo,
                            bordered: (widget.userData.gender == "Female") ? false : true,
                            textColor: (widget.userData.gender == "Female") ? Colors.white : null,
                            iconColor: (widget.userData.gender == "Female") ? Colors.white : null,
                            icon: FontAwesomeIcons.venus,
                            label: "Female",
                            onTap: () => setState(() {
                              widget.userData.gender = "Female";
                            }),
                          ),
                          ChipWidget(
                            color: Colors.indigo,
                            bordered: (widget.userData.gender == "Non-binary") ? false : true,
                            textColor: (widget.userData.gender == "Non-binary") ? Colors.white : null,
                            iconColor: (widget.userData.gender == "Non-binary") ? Colors.white : null,
                            icon: FontAwesomeIcons.venusMars,
                            label: "Other",
                            onTap: () => setState(() {
                              widget.userData.gender = "Non-binary";
                            }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'RELATIONSHIP STATUS',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColour.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RelationshipStatusButton(
                        editable: true,
                        shouldExpand: true,
                        label: (widget.userData.relationshipStatus != null) ? widget.userData.relationshipStatus! : "Click to select",
                        onSave: (relationshipStatus) => setState(() {
                          widget.userData.relationshipStatus = relationshipStatus;
                        }),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_key.currentState!.validate()) return;

                            setState(() {
                              widget.userData.firstName = _firstName.text;
                              widget.userData.lastName = _lastName.text;
                            });

                            context.goNamed("register_description", extra: widget.userData);
                          },
                          child: Text("Next"),
                          style: ElevatedButton.styleFrom(
                            primary: kTertiaryColour,
                            onPrimary: kWhiteColour,
                            fixedSize: const Size(300, 100),
                            shadowColor: kTertiaryColour,
                            elevation: 12,
                            textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
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
