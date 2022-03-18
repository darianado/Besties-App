import 'package:flutter/material.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/textStyles.dart';

class University extends StatefulWidget {

    University({Key? key, required this.userData}) : super(key: key);

  UserData userData;

  @override
  _UniversityState createState() => _UniversityState(userData: userData);

}

class _UniversityState extends State<University> {
    _UniversityState({required this.userData}) ;

    UserData userData;
  String dropdownValue = 'Select university';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: dropdownValue,
            items: <String>[
              'Select university',
              'Birkbeck, University of London',
              'Brunel University London',
              'City, University of London',
              'Goldsmiths, University of London',
              'Imperial College London',
              "King's College London",
              'Kingston University',
              'London Metropolitan University',
              'London School of Economics',
              'London South Bank University',
              'Middlesex University',
              'Queen Mary University of London',
              'Royal Holloway, University of London',
              'SOAS, University of London',
              "St George's, University of London",
              "St Mary's University, Twickenham",
              'University College London',
              'University of East London',
              'University of Greenwich',
              'University of Roehampton',
              'University of the Arts London',
              'University of West London',
              'University of Westminster'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                userData.university=newValue;
              });
            },
          ),
        ),
      ),
    );
  }
}

Expanded buildNameSpace(@required String spaceLabel, @required TextEditingController validator, BuildContext context) {
  return Expanded(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanDown: (_) {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: TextFormField(
        controller: validator,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            labelText: spaceLabel),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
    ),
  );
}

Icon buildIcon(IconData iconInput, Color colorInput) {
  return Icon(
    iconInput,
    color: colorInput,
    size: 24.0,
  );
}

SizedBox buildNext(GlobalKey key, BuildContext context, String nextPage) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return SizedBox(
    width: 0.80 * screenWidth,
    height: 0.07 * screenHeight,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: kButtonBackground,
          onPrimary: kWhiteColour,
          fixedSize: const Size(300, 100),
          shadowColor: kButtonBackground,
          elevation: 12,
          textStyle: kLargeButtonTextStyle,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      onPressed: () {
        if (((key.currentState as FormState).validate()) == true) {
          Navigator.pushNamed(context, nextPage);
        }
      },
      child: const Text(" NEXT"),
    ),
  );
}




