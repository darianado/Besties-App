import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/textStyles.dart';

class IconContent extends StatelessWidget {
  final String label;
  final Icon icon;

  const IconContent({required this.label, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(
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

//create simple icons by a giving icon and a colour
Icon buildIcons(IconData iconInput, Color colourInput) {
  return Icon(
    iconInput,
    color: colourInput,
  );
}

Icon buildIconWithSize(IconData iconInput, Color colourInput, double size) {
  return Icon(
    iconInput,
    color: colourInput,
    size: size,
  );
}

IconData getIconForGender(String? gender) {
  switch (gender?.toLowerCase()) {
    case "male":
      return FontAwesomeIcons.mars;
    case "female":
      return FontAwesomeIcons.venus;
    default:
      return FontAwesomeIcons.venusMars;
  }
}
