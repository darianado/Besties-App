import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/widget/select_interests.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';

import '../../constants/borders.dart';
import '../../constants/textStyles.dart';

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
            backgroundColor: kWhiteColour,
            expandedHeight: 100,
            collapsedHeight: 130,
            leading: IconButton(
              onPressed: () => context.goNamed(registerDescriptionScreenName,
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
                padding: const EdgeInsets.fromLTRB(
                    leftRightPadding, 5, leftRightPadding, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Finally, what do you like?',
                        style: Theme.of(context).textTheme.headline4?.apply(
                            color: kSecondaryColour, fontWeightDelta: 2),
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
              padding: const EdgeInsets.all(leftRightPadding),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.apply(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: PillButtonFilled(
                      text: "Done",
                      backgroundColor: kTertiaryColour,
                      textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: kWhiteColour),
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
