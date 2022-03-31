import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/home/chat/components/chat_button.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';

/**
 * The screen that displays the profile of a user after a match occurred.
 */

class MatchProfileScreen extends StatelessWidget {
  final UserMatch userMatch;

  const MatchProfileScreen({Key? key, required this.userMatch}) : super(key: key);

  /// This method builds a widget that displays the profile of a match.
  /// It contains the basic information about the matched user,
  /// a Chat button in order to start a conversation and
  /// a Close button to exit the screen.
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
          child: const Icon(
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
