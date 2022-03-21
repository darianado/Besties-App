import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/Interests/interest.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';

class DisplayInterests extends StatelessWidget {
  const DisplayInterests({
    Key? key,
    required this.items,
    this.wiggling = false,
    this.mini = true,
    this.onTap,
  }) : super(key: key);

  final List<Interest> items;
  final bool wiggling;
  final bool mini;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: items.map((interest) {
        if (wiggling) {
          return ShakeAnimatedWidget(
            duration: const Duration(milliseconds: 200),
            shakeAngle: Rotation.deg(z: 1.5),
            child: chip(interest.title),
          );
        } else {
          return chip(interest.title);
        }
      }).toList(),
    );
  }

  Widget chip(String label) {
    return ChipWidget(
      color: kTertiaryColour,
      bordered: false,
      label: label,
      capitalizeLabel: true,
      mini: mini,
      textColor: Colors.white,
      onTap: (onTap != null) ? (() => onTap!()) : (null),
    );
  }
}
