import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import '../alerts.dart';

class DateOfBirthButton extends StatelessWidget {
  final bool editable;
  final bool wiggling;
  final bool shouldExpand;
  final String label;
  final Color color;
  final Function(DateTime?)? onSave;

  DateOfBirthButton({Key? key,
    this.wiggling = false,
    this.editable = false,
    this.shouldExpand = false,
    required this.label,
    this.onSave,
    this.color = Colors.green})
      : super(key: key);


  bool validAge(DateTime selectedDate) {
    return (DateTime.now().difference(selectedDate) > Duration(days: 5844));
  }


  DateTime validDate(DateTime dateNow) {
    dateNow =  DateTime.now();
    DateTime limitDate = dateNow.subtract(Duration(days: 5844));
    return limitDate;
  }

  @override
  Widget build(BuildContext context) {
    if (wiggling) {
      return ShakeAnimatedWidget(
        duration: Duration(milliseconds: 200),
        shakeAngle: Rotation.deg(z: 1.5),
        child: chip(context),
      );
    } else {
      return chip(context);
    }
  }

  Widget chip(BuildContext context) {
    return ChipWidget(
      color: color,
      icon: FontAwesomeIcons.birthdayCake,
      label: label,
      shouldExpand: shouldExpand,
      onTap: getOnTap(context),
    );
  }

  Function? getOnTap(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    if (!editable) return null;

    final _uid = _userState.user?.user?.uid;
    final _dob = _userState.user?.userData?.dob;

    return () async => _selectDate(context, _uid, _dob);
  }

  void _selectDate(BuildContext context, String? uid, DateTime? dob) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now()
      //validDate(DateTime.now()),
    );

   // if (picked != null) onSave!(picked);

        if (picked != null && picked != dob)
        {
          if(validAge(picked))
          {
            onSave!(picked);
          }
          else{
            showCalendarAlertDialog(context);
          }
        }
      }
    }

