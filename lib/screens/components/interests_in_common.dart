import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/user_data.dart';

/// A widget that displays how many interests in common the user has with
/// the viewed user's profile.
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

  /// Turns a number into a string.
  String numberToString(int number) {
    if (number == 0) {
      return "NO";
    } else {
      return "$number";
    }
  }
}
