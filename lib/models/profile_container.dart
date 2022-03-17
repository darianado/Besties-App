import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:blur/blur.dart';

import '../screens/components/buttons/bio_field.dart';
import '../screens/components/buttons/edit_dob_button.dart';
import '../screens/components/buttons/gender_button.dart';
import '../screens/components/buttons/relationship_status_button.dart';
import '../screens/components/buttons/university_button.dart';
import '../services/user_state.dart';

//  Widget to display a profile in the main feed.
//  Currently filled with random names and locations.
class ProfileContainer extends StatelessWidget {
  final UserData profile;

  const ProfileContainer({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(profile.profileImageUrl ??
              "assets/images/empty_profile_picture.jpg"),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.16,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  kWhiteColour,
                  Color.fromARGB(0, 255, 255, 255),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.mirror,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                      ),
                      context: context,
                      builder: (context) =>
                          CompleteProfileDetails(profile: profile));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PartialProfileDetails(
                      profile: profile,
                    ),
                    LikeProfileButton(profile: profile, userState: _userState),
                  ],
                ),
              ),
            ),
          )
          // .frosted(
          //   frostOpacity: 0,
          //   frostColor: Color.fromARGB(255, 255, 255, 255),
          //   blur: 4,
          //   width: MediaQuery.of(context).size.width,
          //   height: 115,
          // ),
        ],
      ),
    );
  }
}

// FloatingActionButton to like the displayed profile.
class LikeProfileButton extends StatelessWidget {

  final UserData profile;
  final UserState userState;

  const LikeProfileButton({Key? key, required this.profile, required this.userState}) : super(key: key);

  // Method that generates an AlertDialog
  void likeProfile(BuildContext context) {
    final FirestoreService _firestoreService = FirestoreService.instance;
    _firestoreService.setAdmirer(profile.uid, userState.user!.user!.uid);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You liked " + (profile.firstName ?? " ") + "!"),
          actions: [
            TextButton(
              child: const Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        likeProfile(context);
      },
      backgroundColor: kSecondaryColour,
      child: const Icon(
        Icons.thumb_up_off_alt_rounded,
        color: kWhiteColour,
      ),
    );
  }
}

// Widget that displays the profile's full name and location arranged in a column.
class PartialProfileDetails extends StatelessWidget {
  final UserData profile;

  const PartialProfileDetails({Key? key, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.5),
          child: Text(
            profile.firstName ?? " ",
            style: const TextStyle(
              fontSize: kProfileNameFontSize,
              color: kSecondaryColour,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(children: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.school_outlined,
              color: kSecondaryColour,
            ),
          ),
          Text(
            profile.university ?? " ",
            style: const TextStyle(
              fontSize: kProfileLocationFontSize,
              color: kSecondaryColour,
              fontWeight: FontWeight.w300,
            ),
          ),
        ]),
      ],
    );
  }
}

// Widget that displays all of the profile's details as a sliding bottom sheet.
class CompleteProfileDetails extends StatelessWidget {
  final UserData profile;

  const CompleteProfileDetails({Key? key, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Text(
                  profile.fullName ?? " ",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kTertiaryColour,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                UniversityButton(
                  label: profile.university ?? " ",
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  children: [
                    DateOfBirthButton(label: (profile.age ?? " ").toString()),
                    GenderButtton(label: profile.gender ?? " "),
                    RelationshipStatusButton(
                        label: profile.relationshipStatus ?? " "),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                BioField(
                  label: profile.bio ?? " ",
                  editable: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "YOU HAVE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: kPrimaryColour.withOpacity(0.3),
                      ),
                    ),
                    const Text(
                      " NO ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: kTertiaryColour,
                      ),
                    ),
                    Text(
                      "INTERESTS IN COMMON!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: kPrimaryColour.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
