import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/screens/components/chip_widget.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';

/**
 * This class represents the model of a reusable widget that is used
 * to display the date of birth related information for the users.
 * The Date of birth button can be editable depending on the place it is used
 * (it can be editable only in the sign up process).
 * In the profile related screens it displays the age of the users.
 */

class DateOfBirthButton extends StatelessWidget {
  final bool editable;
  final bool wiggling;
  final bool shouldExpand;
  final String label;
  final Color color;
  final Function(DateTime?)? onSave;

  const DateOfBirthButton(
      {Key? key,
      this.wiggling = false,
      this.editable = false,
      this.shouldExpand = false,
      required this.label,
      this.onSave,
      this.color = Colors.green})
      : super(key: key);


  /**
   * This method checks if an user has the valid age for using the application.
   * @param : DateTime - the date the users select
   * @return: true if the user is over 16, false otherwise
   */

  bool validAge(DateTime selectedDate) {
    return (DateTime.now().difference(selectedDate) > const Duration(days: sixteenYearsInDays));
  }

  /**
   * This method computes the date that occured 16 years from th moment the user uses the application
   * @return The DateTime from 16 years ago
   */

  DateTime validDate() {
    DateTime dateNow = DateTime.now();
    DateTime limitDate = dateNow.subtract(const Duration(days: sixteenYearsInDays));
    return limitDate;
  }


  /**
   * The widget wiggles when it can be editable
   */
  @override
  Widget build(BuildContext context) {
    if (wiggling) {
      return ShakeAnimatedWidget(
        duration: const Duration(milliseconds: 200),
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

  /**
   * This method allows users to tap on the button in the instances when it is ediatble.
   * This way they will trigger the birthday date selection functionality.
   */

  Function? getOnTap(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    if (!editable) return null;

    final _uid = _userState.user?.user?.uid;
    final _dob = _userState.user?.userData?.dob;

    return () async => _selectDate(context, _uid, _dob);
  }

  /**
   * This asyncronous method allows the user to select their birthday.
   * It triggers a calendar being displayed on the screen.
   */

  void _selectDate(BuildContext context, String? uid, DateTime? dob) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: validDate(),
      firstDate: DateTime(1900),
      lastDate: validDate(),
      fieldHintText: 'mm/dd/yyyy',
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: secondaryColour),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) onSave!(picked);
  }
}
