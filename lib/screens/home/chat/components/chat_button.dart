import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';

class OpenChatButton extends StatelessWidget {
  final Function onPressed;

  const OpenChatButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PillButtonFilled(
      text: "Chat",
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      textStyle: Theme.of(context).textTheme.titleLarge?.apply(color: whiteColour),
      iconPadding: 10,
      icon: const Icon(
        FontAwesomeIcons.comments,
        color: whiteColour,
        size: 20,
      ),
      onPressed: onPressed,
    );
  }
}
