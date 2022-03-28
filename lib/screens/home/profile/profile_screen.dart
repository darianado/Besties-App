import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

///The screen displays the profile of the current user

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return ProfileInformation(
      userData: _userState.user?.userData,
      editable: false,
      rightAction: Padding(
        padding: const EdgeInsets.only(right: leftRightPadding),
        child: RoundActionButton(
          onPressed: () => context.goNamed(editProfileScreenName, params: {pageParameterKey: profileScreenName}),
          child: const Icon(
            FontAwesomeIcons.pen,
            color: whiteColour,
            size: 22,
          ),
        ),
      ),
      bottomSection: Column(children: [
        PillButtonFilled(
          text: "Change password",
          expandsWidth: true,
          textStyle: Theme.of(context).textTheme.titleMedium?.apply(color: whiteColour),
          icon: const Icon(
            FontAwesomeIcons.lock,
            color: whiteColour,
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
          textStyle: Theme.of(context).textTheme.titleMedium?.apply(color: Colors.red),
          icon: const Icon(
            FontAwesomeIcons.signOutAlt,
            color: Colors.red,
            size: 18.0,
          ),
          onPressed: () => _userState.signOut(),
        ),
      ]),
    );
  }
}
