import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';

/**
 * This class represents a model of a stateless widget that is aligned
 * in the center left side.
 */

class LeftAlignedHeadline extends StatelessWidget {
  final String text;

  const LeftAlignedHeadline({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text,
          style: const TextStyle(
            color: secondaryColour,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
    );
  }
}
