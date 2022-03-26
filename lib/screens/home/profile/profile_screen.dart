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
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';

///The screen displays the profile of the current user

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return ProfileInformation(
      editable: false,
      rightAction: Padding(
        padding: const EdgeInsets.only(right: leftRightPadding),
        child: FloatingActionButton(
          heroTag: null,
          onPressed: () => context.goNamed(editProfileScreenName, params: {pageParameterKey: profileScreenName}),
          backgroundColor: tertiaryColour,
          elevation: 0,
          child: Icon(
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
          backgroundColor: tertiaryColour,
          icon: Icon(
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
          icon: Icon(
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
