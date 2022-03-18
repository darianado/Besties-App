import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/components/widget/chip_widget.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/components/widget/display_interests.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    final _userState = Provider.of<UserState>(context);

    const double profileImageRadius = 100;
    const double profileHeaderExtendedHeight = 430;
    const double profileHeaderCollapsedHeight = 220;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: profileHeaderExtendedHeight,
            collapsedHeight: profileHeaderCollapsedHeight,
            automaticallyImplyLeading: false,
            excludeHeaderSemantics: false,
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: Material(
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  color: kTertiaryColour,
                  child: InkWell(
                    child: IconButton(
                      onPressed: () => context.pushNamed("edit_profile", params: {'page': 'profile'}),
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: CachedImage(url: _userState.user?.userData?.profileImageUrl),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: Column(
                children: [
                  Text(
                    _userState.user?.userData?.fullName ?? "-",
                    style: TextStyle(
                      color: kTertiaryColour,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  UniversityButton(
                    label: _userState.user?.userData?.university ?? "",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    children: [
                      DateOfBirthButton(label: "${_userState.user?.userData?.age}"),
                      GenderButtton(label: _userState.user?.userData?.gender ?? ""),
                      RelationshipStatusButton(label: _userState.user?.userData?.relationshipStatus ?? ""),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BioField(
                    label: _userState.user?.userData?.bio ?? " ",
                    editable: false,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "INTERESTS",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: kPrimaryColour.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DisplayInterests(
                    items: _userState.user?.userData?.flattenedInterests ?? [],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () => context.pushNamed("edit_password", params: {'page': 'profile'}),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        kTertiaryColour.withOpacity(0.8),
                      ),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.lock,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Change password"),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => _userState.signOut(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red.shade100),
                      primary: Colors.red,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.signOutAlt,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Sign out"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
