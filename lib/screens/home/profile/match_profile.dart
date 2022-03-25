import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/components/widget/display_interests.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';

///The screen displays the profile of the current user
///

class MatchProfileScreen extends StatefulWidget {
  const MatchProfileScreen({Key? key}) : super(key: key);

  @override
  _MatchProfileScreenState createState() => _MatchProfileScreenState();
}

class _MatchProfileScreenState extends State<MatchProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    //const double profileImageRadius = 100;
    const double profileHeaderExtendedHeight = 350;
    const double profileHeaderCollapsedHeight = 220;

    return Scaffold(
      backgroundColor: whiteColour,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: profileHeaderExtendedHeight,
            collapsedHeight: profileHeaderCollapsedHeight,
            automaticallyImplyLeading: false,
            excludeHeaderSemantics: false,
            backgroundColor: Colors.transparent,
            flexibleSpace:
            CachedImage(url: _userState.user?.userData?.profileImageUrl),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: leftRightPadding, right: leftRightPadding, bottom: 15),
              child: Column(
                children: [
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
                            color: secondaryColour.withOpacity(0.3),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
