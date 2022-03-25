import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';

class MatchDialog extends StatelessWidget {
  final String? otherName;
  final String? myImage;
  final String? otherImage;

  const MatchDialog({
    Key? key,
    required this.otherName,
    required this.myImage,
    required this.otherImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, otherName, myImage, otherImage),
    );
  }
}

dialogContent(BuildContext context, String? matchName, String? myImage,
    String? otherImage) {
  return Stack(
    children: [
      //...bottom card part,
      Container(
        padding: const EdgeInsets.fromLTRB(
          Consts.padding,
          Consts.avatarRadius + 20,
          Consts.padding,
          Consts.padding,
        ),
        margin: const EdgeInsets.only(top: Consts.avatarRadius),
        decoration: BoxDecoration(
          color: whiteColour,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding),
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
              },
            ),
          ],
        ),
      ),

      //...top circlular image part,
      Positioned(
        left: Consts.padding,
        right: Consts.padding - 110,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              myImage ?? "assets/images/empty_profile_picture.jpg"),
          radius: Consts.avatarRadius,
        ),
      ),

      Positioned(
        left: Consts.padding - 110,
        right: Consts.padding,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              otherImage ?? "assets/images/empty_profile_picture.jpg"),
          radius: Consts.avatarRadius,
        ),
      ),
    ],
  );
}

class Consts {
  Consts._();

  static const double padding = 50.0;
  static const double avatarRadius = 75.0;
}
