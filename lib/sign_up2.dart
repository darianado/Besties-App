
import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:project_seg/reusableCard.dart';
import 'constants.dart';
import 'iconContent.dart';


enum Gender {
  male,
  female,
  other
}

String genderLabel(Gender gender) {
  switch(gender) {
    case Gender.male: return "MALE";
    case Gender.female: return "FEMALE";
    case Gender.other: return "OTHER";
  }
}

class SignUp2 extends StatefulWidget {
  @override
  _SignUp2State createState() => _SignUp2State();

}

class _SignUp2State extends State<SignUp2> {

  final GlobalKey _key = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _gender = TextEditingController();

  DateTime selectedDate = DateTime.now();
  bool dateChanged = false;
  Gender selectedGender = Gender.other;

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      dateChanged = true;
      setState(() {
        selectedDate = picked;
      }
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _dob.dispose();
    _gender.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Sign Up'),
      ),

      body:
      Form(
        key: _key,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: Text('About you',
                    style: TextStyle(
                        fontSize: 30.0
                    )),
              ),
              const SizedBox(height: 50),
              Row(
                children: <Widget>[
                  buildIcon(Icons.account_balance_outlined, Colors.black),
                  SizedBox(width: 10),
                  buildNameSpace('First name', _firstName),
                  SizedBox(width: 10),
                  buildNameSpace('Last name', _lastName),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildIcon(Icons.cake_outlined, Colors.black),
                  SizedBox(width: 10),
                  // SizedBox(
                  //   width: 20.0,
                  // ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () => _selectDate(context), // Refer step 3
                      child: Text(
                        dateChanged == false
                            ? 'Select date of birth'
                            : "${selectedDate.toLocal()}".split(' ')[0],
                        style:
                        TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  buildIcon(Icons.transgender_outlined, Colors.black),
                  SizedBox(width: 10),
                  genderOptions(Gender.male),
                  genderOptions(Gender.female),
                  genderOptions(Gender.other),
                ],
              ),
              const SizedBox (height: 30),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildIcon(Icons.favorite, Colors.pink),
                    Expanded(
                      child: RelationshipStatus(),
                    ),
                  ]
              ),
              buildNext(context, '/signup3')
            ]
        ),
      ),
    );
  }

  ElevatedButton buildNext(BuildContext context, String nextPage) {
    return ElevatedButton(
              onPressed: () {
                if (((_key.currentState as FormState).validate()) == true) {
                  Navigator.pushNamed(context, nextPage);
                }
              },
              child: const Text(" NEXT"),
            );
  }

  Expanded genderOptions(@required Gender gender) {
    return Expanded(
      child: ReusableCard(
        color: selectedGender == gender
            ? kActiveCardColor
            : kInactiveCardColor,
        cardChild: IconContent(
          icon: Icon(Icons.lock),
          label: genderLabel(gender),
        ),
        onPress: () {
          setState(() {
            selectedGender = gender;
          });

        },
      ),
    );
  }


}





