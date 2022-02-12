import 'package:flutter/material.dart';

class SignUp3 extends StatefulWidget {
  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Sign Up'),
      ),

      body:
      Form (
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              const Padding(
                padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: Text('Tell us about yourself',
                style: TextStyle(
                  fontSize: 30.0
                ) ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      icon: const Icon(Icons.house),
                      labelText: 'Short Description'
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: University(),
              ),
              const SizedBox (height: 300),
              ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/signup4');
                    },
                    child: const Text(" NEXT"),
                  )

            ]
        ),
      ),
    );
  }
}

class University extends StatefulWidget {
  @override
  State<University> createState() => _UniversityState();
}

class _UniversityState extends State<University> {
  String dropdownValue = 'Select your university';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: dropdownValue,
            items: <String>['Select your university',
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
              });
            },
          ),
        ),
      ),
    );
  }
}