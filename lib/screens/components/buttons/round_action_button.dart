import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';

/// A widget that displays its [child] on a [FloatingActionButton].
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
