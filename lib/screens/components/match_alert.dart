import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/UserMatch.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';

import '../../router/route_names.dart';

class MatchDialog extends StatelessWidget {
  final String? otherName;
  final String? myImage;
  final String? otherImage;
  final UserMatch? userMatch;

  const MatchDialog({
    Key? key,
    required this.otherName,
    required this.myImage,
    required this.otherImage,
    required this.userMatch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, otherName, myImage, otherImage, userMatch),
    );
  }
}

dialogContent(BuildContext context, String? matchName, String? myImage,
    String? otherImage, UserMatch? userMatch) {
  return Stack(
    children: [
      //...bottom card part,
      Container(
        padding: const EdgeInsets.fromLTRB(
            Consts.padding, 70, Consts.padding, Consts.padding),
        margin: const EdgeInsets.only(top: 70),
        decoration: BoxDecoration(
          color: whiteColour,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: [
            const SizedBox(height: 15.0),
            Text(
              "It's a match!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 15.0),
            PillButtonFilled(
              text: "Text ${matchName.toString()} now",
              backgroundColor: tertiaryColour,
              expandsWidth: true,
              textStyle: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.apply(color: whiteColour),
              onPressed: () {
                Navigator.of(context).pop(); // To close the dialog
                context.goNamed(matchChatScreenName, extra: userMatch, params: {pageParameterKey: chatScreenName});
              },
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //...top left circlular image part
          Positioned(
            left: Consts.padding - 110,
            right: Consts.padding,
            child: Stack(
              children: [
                Container(
                  width: Consts.avatarRadius,
                  height: Consts.avatarRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColour.withOpacity(0.4),
                  ),
                ),
                Container(
                  width: Consts.avatarRadius,
                  height: Consts.avatarRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(otherImage ??
                          "assets/images/empty_profile_picture.jpg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //...top right circlular image part
          Positioned(
            left: Consts.padding - 110,
            right: Consts.padding,
            child: Stack(
              children: [
                Container(
                  width: Consts.avatarRadius,
                  height: Consts.avatarRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: whiteColour.withOpacity(0.4),
                  ),
                ),
                Container(
                  width: Consts.avatarRadius,
                  height: Consts.avatarRadius,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          myImage ?? "assets/images/empty_profile_picture.jpg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

class Consts {
  Consts._();

  static const double padding = 40.0;
  static const double avatarRadius = 125.0;
}
