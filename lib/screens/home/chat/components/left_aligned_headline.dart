import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';

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
          style: TextStyle(
            color: secondaryColour,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          )),
    );
  }
}
