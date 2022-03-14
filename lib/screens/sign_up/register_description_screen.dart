import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/home/profile/components/university_button.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:provider/provider.dart';

class RegisterDescriptionScreen extends StatefulWidget {
  RegisterDescriptionScreen({Key? key, required this.userData}) : super(key: key);

  UserData userData;

  @override
  _RegisterDescriptionScreenState createState() => _RegisterDescriptionScreenState();
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
          Color(0xFFFEFCFB),
          Color(0xFFE2F9FE),
          Color(0xFFD8F8FF),
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
              backgroundColor: Colors.white,
              expandedHeight: 150,
              collapsedHeight: 130,
              leading: IconButton(
                onPressed: () => context.goNamed("register_photo", extra: widget.userData),
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
                  child: Text(
                    '... and a bit more about ${widget.userData.firstName}',
                    style: TextStyle(
                      fontSize: 29.0,
                      fontWeight: FontWeight.bold,
                      color: kSecondaryColour,
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'UNIVERSITY',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColour.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      UniversityButton(
                        editable: true,
                        shouldExpand: true,
                        color: kSecondaryColour,
                        label: widget.userData.university ?? "Select your university",
                        onSave: (university) => setState(() {
                          widget.userData.university = university;
                        }),
                      ),
                      (couldNotValidateUniversity)
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    "You must fill in this field",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'BIO / SHORT DESCRIPTION',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColour.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                          controller: _bio,
                          minLines: 6,
                          maxLength: _contextState.context?.maxBioLength ?? 200,
                          maxLines: 10,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide.none),
                            labelText: "Enter a bio here...",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: kLightTertiaryColour,
                          ),
                          onChanged: (value) => widget.userData.bio = value,
                          textInputAction: TextInputAction.next,
                          validator: (content) {
                            if (content == null || content.isEmpty) return "A bio is required";
                          }),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!_key.currentState!.validate()) return;

                            if (widget.userData.university == null) {
                              setState(() {
                                couldNotValidateUniversity = true;
                              });
                              return;
                            }
                            couldNotValidateUniversity = false;

                            context.goNamed("register_interests", extra: widget.userData);
                          },
                          child: Text("Next"),
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
