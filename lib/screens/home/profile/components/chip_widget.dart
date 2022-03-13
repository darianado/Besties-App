import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final Color color;
  final bool bordered;
  final IconData? icon;
  final Color? iconColor;
  final String? label;
  final bool capitalizeLabel;
  final Color? textColor;
  final Function? onTap;

  const ChipWidget(
      {Key? key,
      required this.color,
      this.bordered = true,
      this.icon,
      this.iconColor,
      this.label,
      this.capitalizeLabel = false,
      this.textColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(
        Radius.circular(100),
      ),
      child: InkWell(
        onTap: (onTap != null) ? (() => onTap!()) : (null),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        child: Container(
          decoration: BoxDecoration(
              border: (bordered == true)
                  ? Border.all(
                      color: color,
                      width: 1,
                    )
                  : null,
              borderRadius: BorderRadiusDirectional.all(
                Radius.circular(100),
              ),
              color: (bordered == true) ? null : color),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                (icon != null)
                    ? Icon(
                        icon,
                        color: (iconColor != null) ? iconColor : color,
                        size: 22,
                      )
                    : Container(),
                (icon != null && label != null)
                    ? SizedBox(
                        width: 5,
                      )
                    : Container(),
                (label != null)
                    ? Text(
                        (capitalizeLabel == true) ? capitalize(label!) : label!,
                        style: TextStyle(color: (textColor != null) ? textColor : color, fontSize: 18),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String capitalize(String label) {
    if (label.length >= 2) {
      return label[0].toUpperCase() + label.substring(1).toLowerCase();
    } else {
      return label.toUpperCase();
    }
  }
}
