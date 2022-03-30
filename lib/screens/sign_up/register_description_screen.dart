import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/screens/components/validation_error.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/utility/form_validators.dart';
import 'package:provider/provider.dart';

import '../../constants/borders.dart';

/**
 * The fourth screen that is displayed through the sign up process.
 * The user is asked to provide details about the university they attend
 * and specify their bio.
 */

class RegisterDescriptionScreen extends StatefulWidget {
  const RegisterDescriptionScreen({Key? key, required this.userData})
      : super(key: key);

  final UserData userData;

  @override
  _RegisterDescriptionScreenState createState() =>
      _RegisterDescriptionScreenState();
}

class _RegisterDescriptionScreenState extends State<RegisterDescriptionScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _university = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  String? validateUniversityError;
  String? validateBioError;

  @override
  void dispose() {
    super.dispose();
    _university.dispose();
    _bio.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _contextState = Provider.of<ContextState>(context);

    final _bioText = widget.userData.bio;
    if (_bioText != null) {
      _bio.text = _bioText;
    }

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.4, 0.8, 1],
        colors: [
          whiteColour,
          whiteColourShade2,
          whiteColourShade3,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              foregroundColor: tertiaryColour,
              backgroundColor: simpleWhiteColour,
              expandedHeight: 150,
              collapsedHeight: 130,
              leading: IconButton(
                onPressed: () => context.goNamed(registerPhotoScreenName,
                    extra: widget.userData),
                icon: const Icon(Icons.arrow_back_ios, color: primaryColour),
                //buildIcons(Icons.arrow_back_ios, kPrimaryColour),
              ),
              flexibleSpace: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      leftRightPadding, 5, leftRightPadding, 5),
                  child: Text(
                    '... and a bit more about ${widget.userData.firstName}',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.apply(color: secondaryColour, fontWeightDelta: 2),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(leftRightPadding),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Text(
                            'UNIVERSITY',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.apply(fontWeightDelta: 1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      UniversityButton(
                        editable: true,
                        shouldExpand: true,
                        color: secondaryColour,
                        label: widget.userData.university ??
                            "Select your university",
                        onSave: (university) => setState(() {
                          widget.userData.university = university;
                        }),
                      ),
                      ValidationError(errorText: validateUniversityError),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Text(
                            'BIO / SHORT DESCRIPTION',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.apply(fontWeightDelta: 1),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                          controller: _bio,
                          minLines: 6,
                          maxLength: _contextState.context?.maxBioLength ?? 200,
                          maxLines: 10,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(radius10),
                                borderSide: BorderSide.none),
                            labelText: "Enter your bio here...",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: lightTertiaryColour,
                          ),
                          onChanged: (value) =>
                              widget.userData.bio = value.trim(),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences),
                      ValidationError(errorText: validateBioError),
                      const SizedBox(height: 35),
                      SizedBox(
                        width: double.infinity,
                        child: PillButtonFilled(
                          text: "Next",
                          textStyle: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                          onPressed: () {
                            if (!_key.currentState!.validate() || !validate())
                              return;

                            context.goNamed(registerInterestsScreenName,
                                extra: widget.userData);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validate() {
    setState(() {
      validateUniversityError = validateUniversity(widget.userData.university);
      validateBioError = validateBio(widget.userData.bio);
    });

    return (validateUniversityError == null && validateBioError == null);
  }
}
