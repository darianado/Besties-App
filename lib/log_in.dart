import 'package:flutter/material.dart';


class Log_In extends StatefulWidget {
  const Log_In({Key? key}) : super(key: key);

  @override
  _Log_InState createState() => _Log_InState();
}

class _Log_InState extends State<Log_In> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Log In'),
      ),

      body:
      Form (
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      icon: const Icon(Icons.email),
                      labelText: 'Email address:'),
                  textInputAction: TextInputAction.next,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                child: TextFormField(
                  obscureText: true,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    icon: new Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                      Navigator.pushNamed(context, '/');
                  },
                  child: Text("Log In")
              ),
              TextButton(
                  child: Text('New here? Sign up now'),
                onPressed: (){
                  Navigator.pushNamed(context, '/');
                },
              ),
            ]
        ),
      ),
    );
  }
}
