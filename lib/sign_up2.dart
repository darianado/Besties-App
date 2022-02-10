import 'package:flutter/material.dart';
import 'package:project_seg/reusableCard.dart';
import 'constants.dart';
import 'iconContent.dart';

enum Gender {
  male,
  female,
  other
}

class Sign_Up2 extends StatefulWidget {
  @override
  _Sign_Up2State createState() => _Sign_Up2State();

}

class _Sign_Up2State extends State<Sign_Up2> {

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
      Form (
        key: _key,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              const Padding(
                padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: Text('About you',
                    style: TextStyle(
                        fontSize: 30.0
                    ) ),
              ),
              const SizedBox(height: 50),
              Row(
                children: <Widget> [
                  Icon(
                    Icons.account_circle_outlined,
                    size: 24.0,
                  ),
                  SizedBox (width: 10),
                  Expanded(
                    child: TextFormField(
                    controller: _firstName,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'First Name'
                    ),
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
                  SizedBox (width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _firstName,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Last Name'
                      ),
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
                  SizedBox (width: 10),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      'Date of birth: ',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // SizedBox(
                  //   width: 20.0,
                  // ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () => _selectDate(context), // Refer step 3
                      child: Text(
                        dateChanged == false ? 'Select date' : "${selectedDate.toLocal()}".split(' ')[0],
                        style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.blue.shade500,
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
                  children: <Widget> [
                    SizedBox (width: 10),
                    Text(
                      'Gender:'
                    ),
                    Expanded(
                      child: ReusableCard(
                        color: selectedGender == Gender.male
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: IconContent(
                          icon: new Icon(Icons.lock),
                          label: 'MALE',
                        ),
                        onPress: (){
                          if(mounted){
                            setState(() {
                              selectedGender = Gender.female;
                            });
                          }
                        },
                      ),
                    ),
                    Expanded(
                        child: ReusableCard(
                          color: selectedGender == Gender.female
                              ? kActiveCardColor
                              : kInactiveCardColor,
                          cardChild: IconContent(
                            icon: new Icon(Icons.lock),
                            label: 'FEMALE',
                          ),
                          onPress: (){
                            if(mounted){
                              setState(() {
                                selectedGender = Gender.female;
                              });
                            }
                          },
                        ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        color: selectedGender == Gender.other
                            ? kActiveCardColor
                            : kInactiveCardColor,
                        cardChild: IconContent(
                          icon: new Icon(Icons.lock),
                          label: 'OTHER',
                        ),
                        onPress: (){
                          if(mounted){
                            setState(() {
                              selectedGender = Gender.other;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              const SizedBox (height: 30),
              ElevatedButton(
                onPressed: (){
                  if(((_key.currentState as FormState).validate()) == true) {
                    Navigator.pushNamed(context, '/signup3');
                  }

                },
                child: const Text(" NEXT"),
              )

            ]
        ),

      ),
    );
  }
}



