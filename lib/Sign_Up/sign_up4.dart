import 'package:flutter/material.dart';
import 'sign_up1.dart';

class SignUp4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Screen 4'),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Go Back To Screen 3'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 30),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: InterestStatus(),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

class InterestStatus extends StatefulWidget {
  @override
  State<InterestStatus> createState() => _InterestStatusState();
}

class _InterestStatusState extends State<InterestStatus> {
  String dropdownValue = 'Select your first interest';
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(dropdownValue),
      children: <Widget>[
        DropdownButton(
            value: 'Cat1',
            items: <String>['Cat1', 'SubCat1', 'SubCat2', 'SubCat3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            }),
        DropdownButton(
            value: 'Cat2',
            items: <String>['Cat2', 'SubCat1', 'SubCat2', 'SubCat3']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            })
      ],
    );
  }
}
