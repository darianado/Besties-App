import 'package:flutter/material.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/Interests/categorized_interests.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/validation_error.dart';
import 'package:project_seg/screens/components/widget/icon_content.dart';
import 'package:project_seg/screens/components/interests/select_interests.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/screens/sign_up/register_basic_info_screen.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';

class RegisterInterestsScreen extends StatefulWidget {
  RegisterInterestsScreen({Key? key, required this.userData}) : super(key: key);

  UserData userData;

  @override
  State<RegisterInterestsScreen> createState() => _RegisterInterestsScreenState();
}

class _RegisterInterestsScreenState extends State<RegisterInterestsScreen> {
  String? validateInterestsError;

  @override
  Widget build(BuildContext context) {
    final _contextState = Provider.of<ContextState>(context);
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
            foregroundColor: tertiaryColour,
            backgroundColor: whiteColour,
            expandedHeight: 100,
            collapsedHeight: 130,
            leading: IconButton(
              onPressed: () => context.goNamed(registerDescriptionScreenName, extra: widget.userData),
              icon: buildIcons(Icons.arrow_back_ios, primaryColour),
            ),
            flexibleSpace: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(leftRightPadding, 5, leftRightPadding, 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Finally, what do you like?',
                        style: Theme.of(context).textTheme.headline4?.apply(color: secondaryColour, fontWeightDelta: 2),
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
                    "It is time to let us know more about your interests.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Please select between ${_contextState.context?.minInterestsSelected} and ${_contextState.context?.maxInterestsSelected} below.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SelectInterests(
                    onChange: (newCategories) {
                      setState(() {
                        widget.userData.categorizedInterests = newCategories;
                      });
                    },
                    selected: widget.userData.categorizedInterests ?? CategorizedInterests(categories: []),
                  ),
                  ValidationError(errorText: validateInterestsError),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: PillButtonFilled(
                      text: "Done",
                      backgroundColor: tertiaryColour,
                      textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: whiteColour),
                      onPressed: () {
                        if (!validate()) return;
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

  bool validate() {
    final _contextState = Provider.of<ContextState>(context, listen: false);

    setState(() {
      validateInterestsError = validateInterests(
          widget.userData.categorizedInterests, _contextState.context?.minInterestsSelected, _contextState.context?.maxInterestsSelected);
    });

    return (validateInterestsError == null);
  }
}
