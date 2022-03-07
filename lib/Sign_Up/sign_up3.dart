import 'package:flutter/material.dart';
import '../widgets.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

class SignUp3 extends StatefulWidget {
  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  final GlobalKey _key = GlobalKey<FormState>();

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
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                        padding:
                        const EdgeInsets.fromLTRB(20.0, 25.0, 2.0, 10.0),
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
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 10.0),
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
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF041731),
                                            width: 1.5)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 80.0),
                                  ),
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                ),
                              )
                            ])
                          ])),

                      // const SizedBox(height: 100),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.pushNamed(context, '/signup4');
                      //   },
                      //   child: const Text(" NEXT"),
                      // )
                      buildNext(_key, context, '/signup4')
                    ]),
              ),
            ),
          )),
    );
  }
}
