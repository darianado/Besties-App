import 'package:flutter/material.dart';
import 'package:project_seg/constants/borders.dart';
import 'package:project_seg/constants/colours.dart';

class PillButtonOutlined extends StatelessWidget {
  final bool isLoading;
  final String text;
  final Color color;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final Icon? icon;
  final Function onPressed;

  const PillButtonOutlined({
    Key? key,
    this.isLoading = false,
    required this.text,
    this.textStyle = const TextStyle(color: Colors.white),
    required this.onPressed,
    this.color = kSecondaryColour,
    this.icon,
    this.padding = const EdgeInsets.all(10.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressed(),
      child: (isLoading)
          ? SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: color,
                strokeWidth: 3,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (icon != null) ? icon! : Container(),
                (icon != null) ? SizedBox(width: 5) : Container(),
                Text(
                  text,
                  style: textStyle,
                ),
              ],
            ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(padding),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
        side: MaterialStateProperty.all(BorderSide(color: color, width: 1)),
      ),
    );
  }
}
