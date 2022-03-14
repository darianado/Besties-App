import 'package:flutter/material.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/models/categories.dart';
import 'package:project_seg/screens/sign_up/components/select_interests.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class RegisterInterestsScreen extends StatefulWidget {
  RegisterInterestsScreen({Key? key, required this.userData}) : super(key: key);

  UserData userData;

  @override
  State<RegisterInterestsScreen> createState() => _RegisterInterestsScreenState();
}

class _RegisterInterestsScreenState extends State<RegisterInterestsScreen> {
  bool couldNotValidateInterests = false;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    void saveToFirestore() {
      final FirestoreService _firestoreService = FirestoreService.instance;

      _firestoreService.saveUserData(widget.userData);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            foregroundColor: kTertiaryColour,
            backgroundColor: Colors.white,
            expandedHeight: 150,
            collapsedHeight: 130,
            leading: IconButton(
              onPressed: () => context.goNamed("register_description", extra: widget.userData),
              icon: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColour,
              ),
            ),
            flexibleSpace: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Finally, what do you like?',
                        style: TextStyle(
                          fontSize: 29.0,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColour,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
                  SelectInterests(
                    initialCategories: widget.userData.categorizedInterests ?? [],
                    onChange: (newCategories) {
                      widget.userData.categorizedInterests = newCategories;
                    },
                  ),
                  (couldNotValidateInterests)
                      ? Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "Ensure you have selected between 1 and 10 interests",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 50),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final _interests = widget.userData.flattenedInterests;

                        if (_interests == null || _interests.length < 1 || _interests.length > 10) {
                          setState(() {
                            couldNotValidateInterests = true;
                          });
                          return;
                        }

                        setState(() {
                          couldNotValidateInterests = false;
                        });

                        saveToFirestore();
                      },
                      child: Text("Done"),
                      style: ElevatedButton.styleFrom(
                        primary: kTertiaryColour,
                        onPrimary: kWhiteColour,
                        fixedSize: const Size(300, 100),
                        shadowColor: kTertiaryColour,
                        elevation: 12,
                        textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
