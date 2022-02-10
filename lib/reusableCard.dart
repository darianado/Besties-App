import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  final Function onPress;

  ReusableCard({
    required this.color,
    required this.cardChild,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress(),
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0),
          color: color,
        ),
      ),
    );
  }
}
