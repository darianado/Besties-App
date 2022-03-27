import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';

class PillButtonFilled extends StatelessWidget {
  final bool isLoading;
  final String text;
  final bool expandsWidth;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Icon? icon;
  final double iconPadding;
  final Function onPressed;

  const PillButtonFilled({
    Key? key,
    this.isLoading = false,
    required this.text,
    this.expandsWidth = false,
    this.textStyle = const TextStyle(color: Colors.white),
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
    this.icon,
    this.iconPadding = 5,
    this.backgroundColor = tertiaryColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Container(
        width: (expandsWidth) ? double.infinity : null,
        child: (isLoading)
            ? Center(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                  child: CircularProgressIndicator(
                    color: textStyle?.color,
                    strokeWidth: 3,
                  ),
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
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        padding: MaterialStateProperty.all<EdgeInsets>(padding),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      ),
    );
  }
}
