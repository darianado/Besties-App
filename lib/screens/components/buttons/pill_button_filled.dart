import 'package:flutter/material.dart';

class PillButtonFilled extends StatelessWidget {
  final bool isLoading;
  final String text;
  final bool expandsWidth;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Icon? icon;
  final Function onPressed;

  const PillButtonFilled({
    Key? key,
    this.isLoading = false,
    required this.text,
    this.expandsWidth = false,
    this.textStyle = const TextStyle(color: Colors.white),
    required this.onPressed,
    this.padding = const EdgeInsets.all(10.0),
    this.icon,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Container(
        width: (expandsWidth) ? double.infinity : null,
        child: (isLoading)
            ? CircularProgressIndicator(
                color: textStyle?.color,
                strokeWidth: 3,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  (icon != null) ? icon! : Container(),
                  (icon != null) ? SizedBox(width: 5) : Container(),
                  Text(
                    text,
                    style: textStyle,
                  ),
                ],
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
