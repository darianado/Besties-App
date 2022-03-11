import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/components/widgets.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';

class RegisterDescriptionScreen extends StatefulWidget {
  RegisterDescriptionScreen({Key? key, required this.userData}) : super(key: key);

  UserData userData;

  @override
  _RegisterDescriptionScreenState createState() => _RegisterDescriptionScreenState(userData: userData);
}

class _RegisterDescriptionScreenState extends State<RegisterDescriptionScreen> {

  _RegisterDescriptionScreenState({Key? key, required this.userData}) ;

  final GlobalKey _key = GlobalKey<FormState>();
  final TextEditingController _university = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  UserData userData;

  @override
  void dispose() {
    super.dispose();
    _university.dispose();
    _bio.dispose();
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
            preferredSize: Size.fromHeight(0.1 * screenHeight), // here the desired height
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(
                color: kSecondaryColour,
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
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(22.0, 10.0, 22.0, 20.0),
                    child: Text('TELL US ABOUT YOURSELF',
                        style: TextStyle(
                          fontSize: 29.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF041731),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 25.0, 2.0, 10.0),
                    child: Column(children: <Widget>[
                      Row(children: const <Widget>[
                        Text('UNIVERSITY',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF041731),
                            )),
                      ]),
                      Row(
                        children: [
                          buildIcon(Icons.school, const Color(0xFF041731)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: University(),
                          ),
                        ],
                      ),
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),
                      child: Column(children: <Widget>[
                        Row(children: const <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Text('BIO / SHORT DESCRIPTION',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF041731),
                                )),
                          ),
                        ]),
                        Row(children: [
                          buildIcon(Icons.cake_outlined, kSecondaryColour),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'You need to enter a short desc';
                                }
                                return null;
                              },
                              controller: _bio,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(color: Color(0xFF041731), width: 1.5)),
                                contentPadding: const EdgeInsets.symmetric(vertical: 80.0),
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                            ),
                          )
                        ])
                      ])),
                  SizedBox(
                    width: 0.80 * screenWidth,
                    height: 0.07 * screenHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        userData.bio=_bio.text;
                        context.pushNamed("register_interests", extra: userData);
                      } ,
                      child: Text("Next"),
                      style: ElevatedButton.styleFrom(
                          primary: kTertiaryColour,
                          onPrimary: kWhiteColour,
                          fixedSize: const Size(300, 100),
                          shadowColor: kTertiaryColour,
                          elevation: 12,
                          textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                ]),
              ),
            ),
          )),
    );
  }
}
