import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';

class ChipWidget extends StatelessWidget {
  final Color color;
  final bool bordered;
  final IconData? icon;
  final Color? iconColor;
  final String? label;
  final bool capitalizeLabel;
  final Color? textColor;
  final Function? onTap;
  final bool mini;
  final bool shouldExpand;

  const ChipWidget({
    Key? key,
    required this.color,
    this.bordered = true,
    this.icon,
    this.iconColor,
    this.label,
    this.capitalizeLabel = false,
    this.textColor,
    this.onTap,
    this.shouldExpand = false,
    this.mini = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius:  kBorderRadiusChip,
      color: Colors.white,
      child: InkWell(
        onTap: (onTap != null) ? (() => onTap!()) : (null),
        borderRadius: kBorderRadiusChip,
        child: Container(
          width: (shouldExpand) ? double.infinity : null,
          decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 1,
              ),
              borderRadius: const BorderRadiusDirectional.all(
                Radius.circular(100),
              ),
              color: (bordered == true) ? null : color),
          child: Padding(
            padding: EdgeInsets.all(((mini) ? 6.0 : 9.0)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (icon != null)
                    ? Icon(
                        icon,
                        color: (iconColor != null) ? iconColor : color,
                        size: (mini) ? 15 : 22,
                      )
                    : Container(),
                (icon != null && label != null)
                    ? const SizedBox(
                        width: 5,
                      )
                    : Container(),
                (label != null)
                    ? Text(
                        (capitalizeLabel == true) ? capitalize(label!) : label!,
                        style: TextStyle(color: (textColor != null) ? textColor : color, fontSize: (mini) ? 16 : 18),
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
