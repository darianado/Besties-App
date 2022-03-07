import 'package:flutter/material.dart';
import 'package:project_seg/categories.dart';




class SignUp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Sign up'),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                  "It is time to choose categories you are interested in.",
                   textAlign: TextAlign.center,
              ),
              Text(
                "Please select at least one interest.",
                textAlign: TextAlign.center,
              ),
              Text(
                "The maximum number of categories you can select is 10",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: InterestStatus(),
                    ),
                  ]
              ),
              const SizedBox(height: 50),
                ElevatedButton(
                   onPressed: (){
                     Navigator.pushNamed(context, '/feed');
                   },
                   child: const Text("FINISH CREATING YOUR PROFILE"),
          ),
            ],
          ),
        ),
      ),
    );
  }
}


