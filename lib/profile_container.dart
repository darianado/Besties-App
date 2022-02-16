import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'profile_class.dart';
import 'constants.dart';

//  Widget to display a profile in the main feed.
//  Currently filled with random names and locations.
class ProfileContainer extends StatelessWidget {
  final Profile profile;

  ProfileContainer({required this.profile});

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
                    Scaffold.of(context)
                        .showBottomSheet((context) => CompleteProfileDetails(
                              profile: profile,
                            ));
                  },
                  child: PartialProfileDetails(
                    profile: profile,
                  ),
                ),
                const LikeProfileButton(),
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
  const LikeProfileButton({
    Key? key,
  }) : super(key: key);

  // Method that generates an AlertDialog
  void likeProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("You liked this profile!"),
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
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.thumb_up_off_alt_rounded,
        color: Colors.blue,
      ),
    );
  }
}

// Widget that displays the profile's full name and location arranged in a column.
class PartialProfileDetails extends StatelessWidget {
  final Profile profile;

  PartialProfileDetails({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              faker.person.firstName(), // TODO: profile.firstName
              style: const TextStyle(
                fontSize: kProfileNameFontSize,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              faker.person.lastName(), // TODO: profile.lastName
              style: const TextStyle(
                fontSize: kProfileNameFontSize,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        Text(
          faker.address.continent(), // TODO: profile.location
          style: const TextStyle(
            fontSize: kProfileLocationFontSize,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}

// Widget that displays all of the profile's details .
class CompleteProfileDetails extends StatelessWidget {
  final Profile profile;

  CompleteProfileDetails({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.50,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              faker.person.firstName(),
              style: const TextStyle(
                fontSize: kProfileNameFontSize,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              faker.person.lastName(),
              style: const TextStyle(
                fontSize: kProfileNameFontSize,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              faker.address.continent(),
              style: const TextStyle(
                fontSize: kProfileNameFontSize,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
