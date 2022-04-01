import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/user_data.dart';

/// A widget that shows the displayed [profile]'s name and university in a [Column].
class PartialProfileDetails extends StatelessWidget {
  final UserData profile;

  const PartialProfileDetails({Key? key, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          profile.firstName ?? " ",
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.apply(color: secondaryColour, fontWeightDelta: 2),
        ),
        const SizedBox(height: 3),
        Row(children: [
          const Padding(
            padding: EdgeInsets.only(right: 7.5),
            child: Icon(
              FontAwesomeIcons.university,
              color: secondaryColour,
            ),
          ),
          Expanded(
            child: Text(
              profile.university ?? "null",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.apply(color: secondaryColour),
            ),
          ),
        ]),
      ],
    );
  }
}
