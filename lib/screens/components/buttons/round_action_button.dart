import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';

/**
 * This class represents a model of a reusable widget that is used
 * to display a widget (for example an icon) and wrap it with another
 * widget to allow functionality when the button is pressed.
 * This class takes a widget to be used as a required argument but
 * can also take a custom fuction to be triggered when the button is pressed.
 */

class RoundActionButton extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  const RoundActionButton({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      clipBehavior: Clip.none,
      onPressed: onPressed,
      backgroundColor: tertiaryColour,
      elevation: 0,
      child: child,
    );
  }
}
