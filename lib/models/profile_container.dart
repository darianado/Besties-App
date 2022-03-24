import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/screens/components/match_alert.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:provider/provider.dart';
import '../constants/borders.dart';
import 'package:project_seg/constants/colours.dart';
import '../constants/constant.dart';
import '../screens/components/sliding_profile_details.dart';
import '../screens/components/widget/icon_content.dart';
import '../services/firestore_service.dart';
import '../services/user_state.dart';
import 'Interests/category.dart';
import 'Interests/interest.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// The Widget that displays a profile's information.
///
/// This Widget is placed within the [FeedScreen]'s [PageView].
/// It is composed of a [NetworkImage], [PartialProfileDetails],
/// a modal bottom sheet that contains [SlidingProfileDetails]
/// and a [LikeProfileButton].
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
          image: NetworkImage(profile.profileImageUrl ?? "assets/images/empty_profile_picture.jpg"),
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
              padding: EdgeInsets.all(leftRightPadding),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    shape: kRoundedRectangulareBorder,
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
                      child: LikeProfileButton(profile: profile, userState: _userState),
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

  /// Returns a [Set] intersection between the user's interests
  /// and the displayed profile's interests
  String getCommonInterests(UserState _userState) {
    Set<String> userInterests = <String>{};
    Set<String> profileInterests = <String>{};

    ///
    for (Category category in _userState.user!.userData!.categorizedInterests!.categories) {
      for (Interest interest in category.interests) {
        userInterests.add(interest.title);
      }
    }
    for (Category category in profile.categorizedInterests!.categories) {
      for (Interest interest in category.interests) {
        profileInterests.add(interest.title);
      }
    }

    dynamic commonInterests = userInterests.intersection(profileInterests).length;
    if (commonInterests == 0) {
      return "NO";
    } else {
      return commonInterests.toString();
    }
  }
}

/// The [FloatingActionButton] to like the displayed profile.
///
/// The [likeProfile] method is called on-tap
class LikeProfileButton extends StatefulWidget {
  final UserData profile;
  final UserState userState;

  const LikeProfileButton({Key? key, required this.profile, required this.userState}) : super(key: key);

  @override
  State<LikeProfileButton> createState() => _LikeProfileButtonState();
}

class _LikeProfileButtonState extends State<LikeProfileButton> with TickerProviderStateMixin {
  /// Likes the displayed profile.
  ///
  /// Updates the database with a [FirestoreService] instance
  /// and generates an [AlertDialog] or a [MatchDialog] if there is a match
  void likeProfile(BuildContext context) async {
    final FirestoreService _firestoreService = FirestoreService.instance;
    //store 'boolean ' from firestore service set like
    bool isMatch = await _firestoreService.setLike(widget.profile.uid, widget.userState.user!.user!.uid);

    if (isMatch) {
      showDialog(
        context: context,
        builder: (BuildContext context) => MatchDialog(
          otherName: widget.profile.firstName,
          myImage: widget.userState.user!.userData!.profileImageUrl,
          otherImage: widget.profile.profileImageUrl,
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("You liked " + (widget.profile.firstName ?? " ") + "!"),
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
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        likeProfile(context);
      },
      //clipBehavior: Clip.hardEdge,
      backgroundColor: kSecondaryColour,
      child: Transform.scale(
        scale: 1.35,
        child: Lottie.asset("assets/lotties/like.json", controller: AnimationController(vsync: this, value: 0)),
      ), //buildIcons(Icons.thumb_up_off_alt_rounded, kWhiteColour),
    );
  }
}

/// The Widget that shows the displayed profile's partial details.
///
/// This Widget is composed of the profile's first name and university
/// arranged in a [Column].
class PartialProfileDetails extends StatelessWidget {
  final UserData profile;

  const PartialProfileDetails({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          profile.firstName ?? " ",
          maxLines: 2,
          style: Theme.of(context).textTheme.headline4?.apply(color: kSecondaryColour, fontWeightDelta: 2),
        ),
        SizedBox(height: 3),
        Row(children: [
          const Padding(
            padding: EdgeInsets.only(right: 7.5),
            child: Icon(
              FontAwesomeIcons.university,
              color: kSecondaryColour,
            ),
          ),
          Expanded(
            child: Text(
              profile.university ?? "null",
              style: Theme.of(context).textTheme.headline6?.apply(color: kSecondaryColour),
            ),
          ),
        ]),
      ],
    );
  }
}
