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
        backgroundColor: Colors.purple,
        title: const Text('Sign Up'),
        leading: const BackButton(
          color: Colors.white,
        ),
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

