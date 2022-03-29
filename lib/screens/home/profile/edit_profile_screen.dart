import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_outlined.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/components/dialogs/delete_account_dialog.dart';
import 'package:project_seg/screens/home/profile/profile_information.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return ProfileInformation(
      userData: _userState.user?.userData,
      editable: true,
      onImageSection: Container(
        color: opaqueBlack,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          "EDIT",
          style: Theme.of(context).textTheme.bodyMedium?.apply(color: whiteColour),
        ),
      ),
      rightAction: Padding(
        padding: const EdgeInsets.only(right: leftRightPadding),
        child: RoundActionButton(
          onPressed: () => context.goNamed(homeScreenName, params: {pageParameterKey: profileScreenName}),
          child: const Icon(
            FontAwesomeIcons.check,
            color: whiteColour,
            size: 22,
          ),
        ),
      ),
      bottomSection: PillButtonOutlined(
        text: "Delete account",
        expandsWidth: true,
        color: Colors.red,
        textStyle: Theme.of(context).textTheme.titleMedium?.apply(color: Colors.red),
        icon: const Icon(
          FontAwesomeIcons.ban,
          color: Colors.red,
          size: 18,
        ),
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return const DeleteAccountDialog();
          },
        ),
      ),
    );
  }
}
