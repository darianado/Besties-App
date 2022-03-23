import 'package:flutter/material.dart';

import '../../../constants/borders.dart';

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final Function onPress;

  const ReusableCard({
    required this.color,
    required this.cardChild,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        child: cardChild,
        margin: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          borderRadius: kCircularBorderRadius1,
          color: color,
        ),
      ),
    );
  }
}
