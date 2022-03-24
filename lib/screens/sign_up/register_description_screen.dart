import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/buttons/pill_button_filled.dart';
import 'package:project_seg/screens/components/buttons/university_button.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:provider/provider.dart';

import '../../constants/borders.dart';
import '../components/widget/icon_content.dart';

class RegisterDescriptionScreen extends StatefulWidget {
  RegisterDescriptionScreen({Key? key, required this.userData})
      : super(key: key);

  UserData userData;

  @override
  _RegisterDescriptionScreenState createState() =>
      _RegisterDescriptionScreenState();
}

class _RegisterDescriptionScreenState extends State<RegisterDescriptionScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _university = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  bool couldNotValidateUniversity = false;

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
          kWhiteColour,
          kWhiteColourShade2,
          kWhiteColourShade3,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              foregroundColor: kTertiaryColour,
              backgroundColor: kSimpleWhiteColour,
              expandedHeight: 150,
              collapsedHeight: 130,
              leading: IconButton(
                onPressed: () => context.goNamed(registerPhotoScreenName,
                    extra: widget.userData),
                icon: buildIcons(Icons.arrow_back_ios, kPrimaryColour),
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
                        ?.apply(color: kSecondaryColour, fontWeightDelta: 2),
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
                      SizedBox(height: 20),
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
                      SizedBox(height: 10),
                      UniversityButton(
                        editable: true,
                        shouldExpand: true,
                        color: kSecondaryColour,
                        label: widget.userData.university ??
                            "Select your university",
                        onSave: (university) => setState(() {
                          widget.userData.university = university;
                        }),
                      ),
                      (couldNotValidateUniversity)
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "You must fill in this field",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.apply(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(height: 40),
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
                      SizedBox(height: 10),
                      TextFormField(
                          controller: _bio,
                          minLines: 6,
                          maxLength: _contextState.context?.maxBioLength ?? 200,
                          maxLines: 10,
                          textAlignVertical: TextAlignVertical.top,
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(radius10),
                                borderSide: BorderSide.none
                            ),
                            labelText: "Enter your bio here...",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: kLightTertiaryColour,
                          ),
                          onChanged: (value) =>
                              widget.userData.bio = value.trim(),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (content) {
                            if (content == null || content.isEmpty)
                              return "A bio is required";
                          }),
                      SizedBox(height: 35),
                      Container(
                        width: double.infinity,
                        child: PillButtonFilled(
                          text: "Next",
                          backgroundColor: kTertiaryColour,
                          textStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: kWhiteColour
                          ),
                          onPressed: () {
                            if (!_key.currentState!.validate()) return;

                            if (widget.userData.university == null) {
                              setState(() {
                                couldNotValidateUniversity = true;
                              });
                              return;
                            }
                            couldNotValidateUniversity = false;

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
}
