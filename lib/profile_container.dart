import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'constants.dart';

//  Widget to display a profile in the main feed.
//  Currently filled with random names and locations.
class ProfileContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/empty_profile_picture.jpg"),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      faker.person.firstName(),
                      style: const TextStyle(
                        fontSize: Constants.profileNameFontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      faker.person.lastName(),
                      style: const TextStyle(
                        fontSize: Constants.profileNameFontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Text(
                  faker.address.continent(),
                  style: const TextStyle(
                    fontSize: Constants.profileLocationFontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
