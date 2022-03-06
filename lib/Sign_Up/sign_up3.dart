import 'package:flutter/material.dart';
import '../widgets.dart';

class SignUp3 extends StatefulWidget {
  @override
  _SignUp3State createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Sign Up'),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22.0, 10.0, 22.0, 30.0),
                    child: Text('TELL US ABOUT YOURSELF',
                        style: TextStyle(
                          fontSize: 29.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF041731),
                        )),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 5.0),
                      child: Column(children: <Widget>[
                        Row(children: const <Widget>[
                          Text('BIO / SHORT DESCRIPTION',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF041731),
                              )),
                        ]),
                        const SizedBox(height: 10),
                        Row(children: [
                          buildIcon(Icons.house, const Color(0xFF041731)),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF041731), width: 1.5)),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 80.0),
                              ),
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                            ),
                          )
                        ])
                      ])),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 5.0),
                    child: Column(children: <Widget>[
                      Row(children: const <Widget>[
                        Text('UNIVERSITY',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF041731),
                            )),
                      ]),
                    ]),
                    //child: University(),
                  ),
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup4');
                    },
                    child: const Text(" NEXT"),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
