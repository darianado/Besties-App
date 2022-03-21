import 'package:flutter/material.dart';
import 'package:project_seg/constants/textStyles.dart';

class IconContent extends StatelessWidget {
  final String label;
  final Icon icon;

  IconContent({required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        SizedBox(
          height: 15.0,
        ),
        Text(
          this.label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}


