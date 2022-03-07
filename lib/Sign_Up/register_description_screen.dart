import 'package:flutter/material.dart';
import '../widgets.dart';
import 'package:go_router/go_router.dart';

class RegisterDescriptionScreen extends StatefulWidget {
  @override
  _RegisterDescriptionScreenState createState() => _RegisterDescriptionScreenState();
}

class _RegisterDescriptionScreenState extends State<RegisterDescriptionScreen> {
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
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: Text('Tell us about yourself', style: TextStyle(fontSize: 30.0)),
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
                      labelText: 'Short Description'),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: University(),
              ),
              const SizedBox(height: 300),
              ElevatedButton(
                onPressed: () => context.pushNamed("register_interests"),
                child: const Text(" NEXT"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
