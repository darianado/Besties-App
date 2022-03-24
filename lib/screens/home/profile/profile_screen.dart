import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/constant.dart';
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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(right: leftRightPadding),
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () => context.goNamed(editProfileScreenName,
                      params: {pageParameterKey: profileScreenName}),
                  backgroundColor: kTertiaryColour,
                  elevation: 0,
                  child: Icon(
                    Icons.edit,
                    color: kWhiteColour,
                    size: 30,
                  ),
                ),
              ),
            ],
            flexibleSpace:
                CachedImage(url: _userState.user?.userData?.profileImageUrl),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  leftRightPadding, 15, leftRightPadding, 15),
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Text(
                    _userState.user?.userData?.fullName ?? "-",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.apply(fontWeightDelta: 2),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
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
                      DateOfBirthButton(
                          label: "${_userState.user?.userData?.age}"),
                      GenderButtton(
                          label: _userState.user?.userData?.gender ?? ""),
                      RelationshipStatusButton(
                          label:
                              _userState.user?.userData?.relationshipStatus ??
                                  ""),
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
                        style: Theme.of(context).textTheme.bodyMedium?.apply(
                            color: kSecondaryColour.withOpacity(0.3),
                            fontWeightDelta: 3),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  DisplayInterests(
                    items: _userState.user?.userData?.categorizedInterests
                            ?.flattenedInterests ??
                        [],
                  ),
                  SizedBox(height: 25),
                  PillButtonFilled(
                    text: "Change password",
                    expandsWidth: true,
                    backgroundColor: kSecondaryColour,
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
                    expandsWidth: true,
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
