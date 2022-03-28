import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class InterestsInCommon extends StatelessWidget {
  const InterestsInCommon({Key? key, required this.profile}) : super(key: key);

  final UserData profile;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    final numberOfInterestsInCommon =
        _userState.user?.userData?.categorizedInterests?.numberOfInterestsInCommonWith(profile.categorizedInterests) ?? 0;

    final numberString = numberToString(numberOfInterestsInCommon);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "YOU HAVE ",
          style: Theme.of(context).textTheme.bodyMedium?.apply(color: secondaryColour.withOpacity(0.3), fontWeightDelta: 2),
        ),
        Text(
          numberString,
          style: Theme.of(context).textTheme.bodyLarge?.apply(fontWeightDelta: 5),
        ),
        (numberOfInterestsInCommon == 1)
            ? Text(
                " INTEREST IN COMMON!",
                style: Theme.of(context).textTheme.bodyMedium?.apply(color: secondaryColour.withOpacity(0.3), fontWeightDelta: 2),
              )
            : Text(
                " INTERESTS IN COMMON!",
                style: Theme.of(context).textTheme.bodyMedium?.apply(color: secondaryColour.withOpacity(0.3), fontWeightDelta: 2),
              ),
      ],
    );
  }

  String numberToString(int number) {
    if (number == 0) {
      return "NO";
    } else {
      return "$number";
    }
  }
}
