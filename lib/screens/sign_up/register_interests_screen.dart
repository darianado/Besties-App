import 'package:flutter/material.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/screens/components/widget/select_interests.dart';
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
  State<RegisterInterestsScreen> createState() =>
      _RegisterInterestsScreenState();
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
            expandedHeight: 100,
            collapsedHeight: 130,
            leading: IconButton(
              onPressed: () => context.goNamed("register_description",
                  extra: widget.userData),
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
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Finally, what do you like?',
                        style: TextStyle(
                          fontSize: 30.0,
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
                    onChange: (newCategories) {
                      setState(() {
                        widget.userData.categorizedInterests = newCategories;
                      });
                    },
                    selected: widget.userData.categorizedInterests ??
                        CategorizedInterests(categories: []),
                  ),
                  (couldNotValidateInterests)
                      ? Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  "Ensure you have selected at least 1 interest",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final _interests = widget.userData.flattenedInterests;

                        if (_interests == null ||
                            _interests.length < 1 ||
                            _interests.length > 10) {
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
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kTertiaryColour),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(10.0)),
                        textStyle: MaterialStateProperty.all(Theme.of(context)
                            .textTheme
                            .headline5
                            ?.apply(fontWeightDelta: 2)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
