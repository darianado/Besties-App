import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets.dart';
import 'package:project_seg/reusable_card.dart';
import '../constants.dart';
import '../icon_content.dart';
import '../gender_implementation.dart';

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
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      dateChanged = true;
      setState(() {
        selectedDate = picked;
      });
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.4, 0.8, 1],
        colors: [
          Color(0xFFFEFCFB),
          Color(0xFFE2F9FE),
          Color(0xFFD8F8FF),
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(0.1 * screenHeight), // here the desired height
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Color(0xFF041731),
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
            // automaticallyImplyLeading: false
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(22.0, 10.0, 22.0, 30.0),
                      child: Text('TELL US ABOUT YOURSELF',
                          style: TextStyle(
                            fontSize: 29.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF041731),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                      child: TextFormField(
                        controller: _firstName,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.person,
                              color: Color(0xFF041731),
                            ),
                            labelText: 'First name'),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                      child: TextFormField(
                        controller: _lastName,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.person,
                              color: Color(0xFF041731),
                            ),
                            labelText: 'Last name'),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 5.0),
                      child: Column(children: <Widget>[
                        Row(children: const <Widget>[
                          Text('BIRTHDAY',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF041731),
                              )),
                        ]),
                        Row(
                          children: [
                            buildIcon(
                                Icons.cake_outlined, const Color(0xFF041731)),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _selectDate(context),
                                style: OutlinedButton.styleFrom(
                                  primary: const Color(0xFFFEFCFB),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                  side: const BorderSide(
                                      color: Color(0xFF041731), width: 1.5),
                                ),
                                child: Text(
                                  dateChanged == false
                                      ? 'Select a date'
                                      : "${selectedDate.toLocal()}"
                                          .split(' ')[0],
                                  style: const TextStyle(
                                    color: Color(0xFF041731),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 5.0),
                      child: Column(children: <Widget>[
                        Row(children: const <Widget>[
                          Text('GENDER',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF041731),
                              )),
                        ]),
                        Row(
                          children: [
                            buildIcon(Icons.transgender_outlined,
                                const Color(0xFF041731)),
                            const SizedBox(
                              width: 10,
                            ),
                            genderOptions(Gender.male),
                            genderOptions(Gender.female),
                            genderOptions(Gender.other),
                          ],
                        ),
                      ]),
                    ),






                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 5.0),
                      child: Column(children: <Widget>[
                        Row(children: const <Widget>[
                          Text('RELATIONSHIP STATUS',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF041731),
                              )),
                        ]),
                        Row(
                          children: [
                            buildIcon(Icons.favorite,
                                const Color(0xFF041731)),
                            const SizedBox(
                              width: 10,
                            ),
                           Expanded(
                            child: RelationshipStatus(),
                          ),
                          ],
                        ),
                      ]),
                    ),

                    buildNext(_key, context, '/signup3')
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Expanded genderOptions(@required Gender gender) {
    
    return Expanded(
      child: ReusableCard(
        color:Colors.transparent, 
        // selectedGender == gender ? kActiveCardColor : kInactiveCardColor,
        cardChild: OutlinedButton(
          onPressed: () {
            setState(() {
              selectedGender = gender;
            });
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: selectedGender == gender ? kActiveCardColor : kInactiveCardColor,
            primary: const Color(0xFFFEFCFB),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            side: const BorderSide(color: Color(0xFF041731), width: 1.5),
          ),
          child: Text(
            genderLabel(gender),
            style: const TextStyle(
              color: Color(0xFF041731),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Text(
        //   genderLabel(gender),
        //   style: const TextStyle(fontSize: 22),
        // ),
        onPress: () {
          setState(() {
            selectedGender = gender;
          });
        },
      ),
    );
  }
}
