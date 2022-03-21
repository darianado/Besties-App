import 'package:flutter/material.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:provider/provider.dart';
import '../constants/constant.dart';
import 'package:project_seg/constants/colours.dart';
import '../constants/textStyles.dart';
import '../screens/components/sliding_profile_details.dart';
import '../services/firestore_service.dart';
import '../services/user_state.dart';
import 'Interests/category.dart';
import 'Interests/interest.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//  Widget to display a profile in the main feed.
//  Currently filled with random names and locations.
class ProfileContainer extends StatelessWidget {
  final UserData profile;

  ProfileContainer({Key? key, required this.profile}) : super(key: key);

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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  kWhiteColour,
                  kGradientColour,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.mirror,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    context: context,
                    builder: (context) => SlidingProfileDetails(
                      profile: profile,
                      commonInterests: getCommonInterests(_userState),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: PartialProfileDetails(
                        profile: profile,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: LikeProfileButton(
                          profile: profile, userState: _userState),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getCommonInterests(UserState _userState) {
    Set<String> userInterests = <String>{};
    Set<String> profileInterests = <String>{};

    for (Category category
        in _userState.user!.userData!.categorizedInterests!.categories) {
      for (Interest interest in category.interests) {
        userInterests.add(interest.title);
      }
    }
    for (Category category in profile.categorizedInterests!.categories) {
      for (Interest interest in category.interests) {
        profileInterests.add(interest.title);
      }
    }

    dynamic commonInterests =
        userInterests.intersection(profileInterests).length;
    if (commonInterests == 0) {
      return "NO";
    } else {
      return commonInterests.toString();
    }
  }
}

// FloatingActionButton to like the displayed profile.
class LikeProfileButton extends StatelessWidget {
  final UserData profile;
  final UserState userState;

  const LikeProfileButton(
      {Key? key, required this.profile, required this.userState})
      : super(key: key);

  // Method that generates an AlertDialog
  void likeProfile(BuildContext context) {
    final FirestoreService _firestoreService = FirestoreService.instance;
    _firestoreService.setLike(profile.uid, userState.user!.user!.uid);

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
        Text(
          profile.firstName ?? " ",
          maxLines: 2,
          style: kProfileContainerStyle,
        ),
        SizedBox(height: 3),
        Row(children: [
          const Padding(
            padding: EdgeInsets.only(right: 7.5),
            child: Expanded(
              child: Icon(
                FontAwesomeIcons.university,
                color: kSecondaryColour,
              ),
            ),
          ),
          Expanded(
            child: Text(
              profile.university ?? "null",
              style: kProfileContainerUniversityStyle,
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
        height: MediaQuery.of(context).size.height * 0.70,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.school_outlined,
                  color: kSecondaryColour,
                ),
              ),
              Text(
                profile.university ?? " ",
                style: kProfileContainerUniversityStyle,
              ),
            ],
          ),
        ));
  }
}
