import 'package:flutter/material.dart';
import 'package:project_seg/models/categories.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class RegisterInterestsScreen extends StatelessWidget {

   RegisterInterestsScreen({Key? key, required this.userData}) : super(key: key);
    UserData userData;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    void saveToFirestore() {
      final FirestoreService _firestoreService = FirestoreService.instance;

      _firestoreService.saveUserData(userData);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Screen 4'),
        backgroundColor: Colors.blue,
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
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                Expanded(
                  child: InterestStatus(),
                ),
              ]),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => saveToFirestore(),
                child: const Text("FINISH CREATING YOUR PROFILE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
