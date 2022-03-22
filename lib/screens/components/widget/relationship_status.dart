import 'package:flutter/material.dart';
import 'package:project_seg/models/User/UserData.dart';


class RelationshipStatus extends StatefulWidget {

  RelationshipStatus({Key? key, required this.userData}) : super(key: key);

  UserData userData;

  @override
  _RelationshipStatusState createState() => _RelationshipStatusState(userData: userData);
}

class _RelationshipStatusState extends State<RelationshipStatus> {
  _RelationshipStatusState({required this.userData}) ;

  UserData userData;

  String dropdownValue = 'Select your relationship status';
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
          value: dropdownValue,
          items: <String>[
            'Select your relationship status',
            'Single',
            'In a relationship',
            'It is complicated',
            'Engaged',
            'Married',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              userData.relationshipStatus = newValue;
            });
          },
        ),
      ),
    );
  }
}