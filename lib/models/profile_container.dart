import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../constants.dart';
import 'package:blur/blur.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../screens/components/buttons/bio_field.dart';
import '../screens/components/buttons/edit_dob_button.dart';
import '../screens/components/buttons/gender_button.dart';
import '../screens/components/buttons/relationship_status_button.dart';
import '../screens/components/buttons/university_button.dart';

//  Widget to display a profile in the main feed.
//  Currently filled with random names and locations.
class ProfileContainer extends StatelessWidget {
  final UserData profile;

  const ProfileContainer({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    LikeProfileButton(profile: profile),
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

  const LikeProfileButton({Key? key, required this.profile}) : super(key: key);

  // Method that generates an AlertDialog
  void likeProfile(BuildContext context) {
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
class CompleteProfileDetails extends StatefulWidget {
  final UserData profile;

  const CompleteProfileDetails({Key? key, required this.profile})
      : super(key: key);

  @override
  State<CompleteProfileDetails> createState() => _CompleteProfileDetailsState();
}

class _CompleteProfileDetailsState extends State<CompleteProfileDetails> {
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: Axis.vertical);
  }

  Future<dynamic> _scrollBackToTop(details) async {
    await controller.scrollToIndex(0,
        duration: const Duration(milliseconds: 500),
        preferPosition: AutoScrollPosition.begin);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.43,
      child: Listener(
        onPointerUp: (details) => _scrollBackToTop(details),
        child: ListView(
          scrollDirection: Axis.vertical,
          controller: controller,
          physics: const ClampingScrollPhysics(),
          children: [
            AutoScrollTag(
              key: const ValueKey(0),
              index: 0,
              controller: controller,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(
                      widget.profile.fullName ?? " ",
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
                      label: widget.profile.university ?? " ",
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
                        DateOfBirthButton(
                            label: (widget.profile.age ?? " ").toString()),
                        GenderButtton(label: widget.profile.gender ?? " "),
                        RelationshipStatusButton(
                            label: widget.profile.relationshipStatus ?? " "),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BioField(
                      label: widget.profile.bio ?? " ",
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
                          " 3 ",
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
            ),
          ],
        ),
      ),
    );
  }
}
