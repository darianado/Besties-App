import 'package:flutter/material.dart';
import 'profile_class.dart';
import '../constants.dart';

//  Widget to display a profile in the main feed.
//  Currently filled with random names and locations.
class ProfileContainer extends StatelessWidget {
  final Profile profile;

  const ProfileContainer({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/empty_profile_picture.jpg", // profile.picture
          ),
          fit: BoxFit.fill,
        ),
      ),
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(context: context, builder: (context) => CompleteProfileDetails(profile: profile));
                    // Scaffold.of(context)
                    //     .showBottomSheet((context) => CompleteProfileDetails(
                    //           profile: profile,
                    //         ));
                  },
                  child: PartialProfileDetails(
                    profile: profile,
                  ),
                ),
                LikeProfileButton(profile: profile),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// FloatingActionButton to like the displayed profile.
class LikeProfileButton extends StatelessWidget {
  final Profile profile;

  const LikeProfileButton({Key? key, required this.profile}) : super(key: key);

  // Method that generates an AlertDialog
  void likeProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You liked ${profile.firstName}!'),
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
  final Profile profile;

  const PartialProfileDetails({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.5),
          child: Text(
            profile.firstName,
            style: const TextStyle(
              fontSize: kProfileNameFontSize,
              color: kSecondaryColour,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(8.0),
        //   child: Text(
        //     profile.lastName,
        //     style: const TextStyle(
        //       fontSize: kProfileNameFontSize,
        //       color: kSecondaryColour,
        //       fontWeight: FontWeight.w300,
        //     ),
        //   ),
        // ),
        //   ],
        // ),
        Row(children: [
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.school_outlined,
              color: kSecondaryColour,
            ),
          ),
          Text(
            profile.continent,
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
  final Profile profile;

  const CompleteProfileDetails({Key? key, required this.profile}) : super(key: key);

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...([profile.firstName, profile.lastName, profile.continent]).map((element) {
                  return Text(
                    element,
                    style: const TextStyle(
                      fontSize: kProfileNameFontSize,
                      color: kSecondaryColour,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList()
              ],
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: kWhiteColour,
              child: const Icon(
                Icons.highlight_off_rounded,
                color: Colors.blue,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}