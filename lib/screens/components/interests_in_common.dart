import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/**
 * This class represents a widget that is used to display
 * how many intrests in common are there between a logged in user
 * and the viewed user's profile. It displays this information in a widget
 * with text in form of "YOU HAVE x INTEREST IN COMMON!" or
 * "YOU HAVE x INTERESTS IN COMMON!", where x is the number of intrests in common.
 */

class InterestsInCommon extends StatelessWidget {
  const InterestsInCommon({Key? key, required this.otherUser, required this.user}) : super(key: key);

  final UserData? user;
  final UserData otherUser;

  @override
  Widget build(BuildContext context) {
    final numberOfInterestsInCommon = user?.categorizedInterests?.numberOfInterestsInCommonWith(otherUser.categorizedInterests) ?? 0;

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

  /**
   * This method turns a number into a string.
   * @param int number - the number to be converted
   *
   * @return the String containing the number if the number was not equal 0
   * or returns "NO" otherwise.
   */

  String numberToString(int number) {
    if (number == 0) {
      return "NO";
    } else {
      return "$number";
    }
  }
}
