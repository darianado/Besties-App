import 'package:flutter/material.dart';
import '../../constants/borders.dart';
import '../../constants/colours.dart';

/**
 * This class represents the model of a reusable widget that is used
 * to display a text or an icon or both in form of a chip. It takes color
 * the chip will have as required argument but allows further customisation.
 */

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
      borderRadius: const BorderRadius.all(radius100),
      color: simpleWhiteColour,
      child: InkWell(
        onTap: (onTap != null) ? (() => onTap!()) : (null),
        borderRadius: const BorderRadius.all(radius100),
        child: Container(
          width: (shouldExpand) ? double.infinity : null,
          decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 1,
              ),
              borderRadius: const BorderRadiusDirectional.all(radius100),
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
                        size: (mini) ? 15 : 25,
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
                        style: TextStyle(
                            color: (textColor != null) ? textColor : color,
                            fontSize: (mini) ? 16 : 18),
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
