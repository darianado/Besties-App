import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/colours.dart';

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
          style: TextStyle(
            color: inactiveSliderColor,
            fontSize: 18.0,
        )),
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

// class IconWidget extends StatelessWidget {
//   final IconData icon;
//   final Color colour;
//
//   const IconWidget({required this.icon, required this.colour});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Icon(
//       icon,
//       color: colour,
//     );
//   }
// }

