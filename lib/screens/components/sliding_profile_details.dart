import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/interests_in_common.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../models/User/user_data.dart';
import 'buttons/bio_field.dart';
import 'buttons/edit_dob_button.dart';
import 'buttons/relationship_status_button.dart';
import 'buttons/university_button.dart';

/// A widget that shows the displayed profile's complete details.
class SlidingProfileDetails extends StatefulWidget {
  final UserData profile;

  const SlidingProfileDetails({Key? key, required this.profile}) : super(key: key);

  @override
  State<SlidingProfileDetails> createState() => _SlidingProfileDetailsState();
}

class _SlidingProfileDetailsState extends State<SlidingProfileDetails> {
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom), axis: Axis.vertical);
  }

  @override
  Widget build(BuildContext context) {
    final UserState _userState = Provider.of<UserState>(context);

    return SingleChildScrollView(
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.all(leftRightPadding),
          child: Column(
            children: [
              Text(
                widget.profile.fullName ?? " ",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3?.apply(color: tertiaryColour, fontWeightDelta: 2),
              ),
              const SizedBox(height: 15),
              UniversityButton(
                label: widget.profile.university ?? " ",
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6.0,
                runSpacing: 6.0,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  DateOfBirthButton(label: (widget.profile.age ?? " ").toString()),
                  GenderButton(label: widget.profile.gender ?? " "),
                  RelationshipStatusButton(label: widget.profile.relationshipStatus ?? " "),
                ],
              ),
              const SizedBox(height: 20),
              BioField(
                label: widget.profile.bio ?? " ",
                editable: false,
              ),
              const SizedBox(height: 25),
              InterestsInCommon(user: _userState.user?.userData, otherUser: widget.profile),
            ],
          ),
        ),
      ),
    );
  }
}
