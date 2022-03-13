import 'package:flutter/material.dart';
import 'package:project_seg/models/gender_implementation.dart';
import 'package:project_seg/screens/components/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class EditProfileScreenOld extends StatefulWidget {
  @override
  _EditProfileScreenOldState createState() => _EditProfileScreenOldState();
}

class _EditProfileScreenOldState extends State<EditProfileScreenOld> {
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
    UserState _userState = Provider.of<UserState>(context);

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
                    onPressed: () {},
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
                Expanded(child: Text("testing")
                    //RelationshipStatus(userData: ),
                    ),
              ]),
              ElevatedButton(
                onPressed: () => context.pushNamed("edit_password", params: {'page': 'profile'}),
                child: const Text("CHANGE YOUR PASSWORD"),
              ),
              ElevatedButton(
                onPressed: () => context.goNamed("home", params: {'page': 'profile'}),
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
