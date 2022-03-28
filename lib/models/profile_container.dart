import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/models/User/user_data.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/components/match_alert.dart';
import 'package:project_seg/screens/components/buttons/round_action_button.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';
import 'package:provider/provider.dart';
import '../constants/borders.dart';
import '../constants/constant.dart';
import '../screens/components/sliding_profile_details.dart';
import '../services/firestore_service.dart';
import '../services/user_state.dart';
import 'Interests/category.dart';
import 'Interests/interest.dart';

/// The Widget that displays a profile's information.
///
/// This Widget is placed within the [FeedScreen]'s [PageView].
/// It is composed of a [NetworkImage], [PartialProfileDetails],
/// a modal bottom sheet that contains [SlidingProfileDetails]
/// and a [LikeProfileButton].
class ProfileContainer extends StatelessWidget {
  final OtherUser profile;
  final Function onLikeComplete;

  const ProfileContainer({
    Key? key,
    required this.profile,
    required this.onLikeComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: CachedImage(url: profile.userData.profileImageUrl),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    whiteColour,
                    gradientColour,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: radius20,
                        ),
                      ),
                      context: context,
                      builder: (context) => SlidingProfileDetails(profile: profile.userData),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: PartialProfileDetails(
                          profile: profile.userData,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: LikeProfileButton(
                          profile: profile,
                          onLikeComplete: onLikeComplete,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// The [FloatingActionButton] to like the displayed profile.
///
/// The [likeProfile] method is called on-tap
class LikeProfileButton extends StatefulWidget {
  final OtherUser profile;
  final Function onLikeComplete;

  const LikeProfileButton({
    Key? key,
    required this.profile,
    required this.onLikeComplete,
  }) : super(key: key);

  @override
  State<LikeProfileButton> createState() => _LikeProfileButtonState();
}

class _LikeProfileButtonState extends State<LikeProfileButton> with TickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService.instance;

  final notLikedValue = 0.0;
  final likedValue = 1.0;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);

    bool isLiked = _userState.user?.userData?.likes?.contains(widget.profile.userData.uid) ?? false;

    final _animationController = AnimationController(vsync: this, value: (isLiked) ? likedValue : notLikedValue);

    return RoundActionButton(
      onPressed: () async {
        if (!isLiked) {
          await _animationController.animateTo(likedValue, duration: Duration(milliseconds: 600));

          widget.onLikeComplete();

          bool isMatch = await _firestoreService.setLike(widget.profile.userData.uid);

          if (isMatch) {
            showDialog(
              context: context,
              builder: (BuildContext context) => MatchDialog(
                otherUser: widget.profile.userData,
              ),
            );
          }
        }
      },
      child: Transform.scale(
        scale: 1.35,
        child: Lottie.asset("assets/lotties/like.json", controller: _animationController),
      ),
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
          style: Theme.of(context).textTheme.headline4?.apply(color: secondaryColour, fontWeightDelta: 2),
        ),
        SizedBox(height: 3),
        Row(children: [
          const Padding(
            padding: EdgeInsets.only(right: 7.5),
            child: Icon(
              FontAwesomeIcons.university,
              color: secondaryColour,
            ),
          ),
          Expanded(
            child: Text(
              profile.university ?? "null",
              style: Theme.of(context).textTheme.headline6?.apply(color: secondaryColour),
            ),
          ),
        ]),
      ],
    );
  }
}
