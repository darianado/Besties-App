import 'package:flutter/material.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/models/gender_implementation.dart';
import 'package:project_seg/screens/components/widgets.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
    
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
       child: Container(
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
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                    child: Text('Edit your information', style: TextStyle(fontSize: 30.0)),
                  ),


                 

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                           const CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage("assets/images/empty_profile_picture.jpg"),
                              ),
                          
                          SizedBox(
                            width: 0.5 * screenWidth,
                            height: 0.04 * screenHeight,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/edit_profile');
                              },
                              child: const Text("UPLOAD NEW PICTURE"),
                              style: ElevatedButton.styleFrom(
                                primary: kTertiaryColour,
                                onPrimary: kWhiteColour,
                                fixedSize: const Size(300, 100),
                                shadowColor: kTertiaryColour,
                                elevation: 12,
                                textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                              
                            ),
                          ),
                      ]),
                   
                  
                      











                      

                  


                Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                      child: TextFormField(
                        controller: _firstName,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(
                              Icons.person,
                              color: kSecondaryColour,
                            ),
                            labelText: 'My first name'),
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
                              color: kSecondaryColour,
                            ),
                            labelText: 'My last name'),
                        textInputAction: TextInputAction.next,
                      ),
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
                          buildIcon(Icons.favorite, const Color(0xFF041731)),
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



                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 5.0),
                    child: SizedBox(
                      width: 0.80 * screenWidth,
                      height: 0.07 * screenHeight,
                      child: ElevatedButton(
                        onPressed: () => context.pushNamed("edit_password", params: {'page': 'profile'}),
                        child: Text("CHANGE YOUR PASSWORD"),
                        style: ElevatedButton.styleFrom(
                            primary: kTertiaryColour,
                            onPrimary: kWhiteColour,
                            fixedSize: const Size(300, 100),
                            shadowColor: kTertiaryColour,
                            elevation: 12,
                            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                  ),



                     Padding(
                       padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 5.0),
                       child: SizedBox(
                        width: 0.80 * screenWidth,
                        height: 0.07 * screenHeight,
                        child: ElevatedButton(
                        onPressed: () => context.goNamed("home", params: {'page': 'profile'}),
                        child: Text("Save Changes"),
                        style: ElevatedButton.styleFrom(
                            primary: kTertiaryColour,
                            onPrimary: kWhiteColour,
                            fixedSize: const Size(300, 100),
                            shadowColor: kTertiaryColour,
                            elevation: 12,
                            textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                                         ),
                                       ),
                     ),





                  
                ]),
              ),
            ),
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
