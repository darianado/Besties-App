import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/components/widget/display_interests.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';

import '../../../constants/textStyles.dart';
import '../../components/widget/icon_content.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    //double screenWidth = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    final _userState = Provider.of<UserState>(context);

    //const double profileImageRadius = 100;
    const double profileHeaderExtendedHeight = 430;
    const double profileHeaderCollapsedHeight = 220;

    return Scaffold(
      backgroundColor: kWhiteColour,
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
                      onPressed: () => context.pushNamed(editProfileScreenName, params: {'page': 'profile'}),
                      icon: buildIconWithSize(FontAwesomeIcons.pen, kWhiteColour, 17.0),
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
              padding: const EdgeInsets.fromLTRB(10, 15, 15, 15),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Text(
                    _userState.user?.userData?.fullName ?? "-",
                    style: kProfileDetailsNameStyle,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  UniversityButton(
                    label: _userState.user?.userData?.university ?? "",
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 20),
                  BioField(
                    label: _userState.user?.userData?.bio ?? " ",
                    editable: false,
                  ),
                  SizedBox(height: 25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "INTERESTS",
                        style: kInterestMatchedStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  DisplayInterests(
                    items: _userState.user?.userData?.flattenedInterests ?? [],
                  ),
                  SizedBox(height: 40),
                  PillButtonFilled(
                    text: "Change password",
                    backgroundColor: kTertiaryColour,
                    icon: Icon(
                      FontAwesomeIcons.lock,
                      size: 18.0,
                    ),
                    onPressed: () => context.pushNamed(
                      editPasswordScreenName,
                      params: {pageParameterKey: profileScreenName},
                    ),
                  ),
                  PillButtonOutlined(
                    text: "Sign out",
                    color: Colors.red,
                    textStyle: TextStyle(color: Colors.red),
                    icon: Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.red,
                      size: 18.0,
                    ),
                    onPressed: () => _userState.signOut(),
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
