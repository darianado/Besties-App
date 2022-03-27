import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/User/UserMatch.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:project_seg/screens/chat/components/chat_button.dart';
import 'package:project_seg/screens/chat/components/round_action_button.dart';
import 'package:project_seg/screens/components/buttons/bio_field.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/components/buttons/edit_dob_button.dart';
import 'package:project_seg/screens/components/buttons/gender_button.dart';
import 'package:project_seg/screens/components/buttons/relationship_status_button.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/components/widget/display_interests.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:go_router/go_router.dart';

///The screen displays the profile of the current user
///
class MatchProfileScreen extends StatelessWidget {
  final UserMatch userMatch;

  MatchProfileScreen({required this.userMatch});

  @override
  Widget build(BuildContext context) {
    return ProfileInformation(
      userData: userMatch.match,
      editable: false,
      onImageSection: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: OpenChatButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.goNamed(matchChatScreenName, extra: userMatch, params: {pageParameterKey: chatScreenName});
          },
        ),
      ),
      rightAction: Padding(
        padding: const EdgeInsets.only(right: leftRightPadding),
        child: RoundActionButton(
          child: Icon(
            Icons.close,
            color: whiteColour,
            size: 22,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
