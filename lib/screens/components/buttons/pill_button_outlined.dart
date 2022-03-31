import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';

/**
 * This class represents a model of a reusable widget that is used
 * to display text in a pill-shaped field.
 * It takes a text to be displayed and the on pressed function as
 * required arguments, but can be customised further.
 */

class PillButtonOutlined extends StatelessWidget {
  final bool isLoading;
  final bool expandsWidth;
  final String text;
  final Color color;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final Icon? icon;
  final double iconPadding;
  final Function onPressed;

  const PillButtonOutlined({
    Key? key,
    this.isLoading = false,
    required this.text,
    this.expandsWidth = false,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 10),
    required this.onPressed,
    this.color = secondaryColour,
    this.icon,
    this.iconPadding = 5,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(),
      child: SizedBox(
        width: (expandsWidth) ? double.infinity : null,
        child: (isLoading)
            ? SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: color,
                  strokeWidth: 3,
                ),
              )
            : Padding(
                padding: EdgeInsets.all(textStyle!.fontSize! * 0.225),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (icon != null) ? icon! : Container(),
                    (icon != null) ? SizedBox(width: iconPadding) : Container(),
                    Text(
                      text,
                      style: textStyle,
                    ),
                  ],
                ),
              ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(padding),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
        side: MaterialStateProperty.all(BorderSide(color: color, width: 1)),
      ),
    );
  }
}
