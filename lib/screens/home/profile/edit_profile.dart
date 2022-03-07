import 'package:flutter/material.dart';
import 'package:project_seg/models/gender_implementation.dart';
import 'package:project_seg/screens/components/widgets.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey _key = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  Gender selectedGender = Gender.other;

  @override
  void dispose() {
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _gender.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Edit profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: Text('Edit your information', style: TextStyle(fontSize: 20.0)),
              ),
              const SizedBox(height: 30),
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/empty_profile_picture.jpg"),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_profile');
                    },
                    child: const Text("UPLOAD NEW PICTURE"),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  buildNameSpace('Edit first name', _firstName, context),
                  SizedBox(width: 10),
                  buildNameSpace('Edit last name', _lastName, context),
                  SizedBox(width: 10),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                children: <Widget>[
                  buildRadio(Gender.male),
                  Text("Male"),
                  SizedBox(
                    width: 20,
                  ),
                  buildRadio(Gender.female),
                  Text("Female"),
                  SizedBox(
                    width: 20,
                  ),
                  buildRadio(Gender.other),
                  Text("Other"),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    labelText: "Edit your bio",
                  ),
                ),
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                Expanded(
                  child: RelationshipStatus(),
                ),
              ]),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit_password');
                },
                child: const Text("CHANGE YOUR PASSWORD"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/feed');
                },
                child: const Text("SAVE NEW INFORMATION"),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Radio<String> buildRadio(@required Gender gender) {
    return Radio(
        value: gender.toString(),
        groupValue: selectedGender.toString(),
        onChanged: (value) {
          setState(() {
            selectedGender = gender;
          });
        });
  }
}
