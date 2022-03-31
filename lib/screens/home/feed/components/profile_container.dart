import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';
import 'package:project_seg/screens/home/feed/components/like_profile_button.dart';
import 'package:project_seg/screens/home/feed/components/partial_profile_details.dart';
import 'package:project_seg/screens/home/feed/feed_screen.dart';

import '../../../../constants/borders.dart';
import '../../../../constants/constant.dart';
import '../../../components/sliding_profile_details.dart';

/**
 * The Widget that displays a profile's information.
 *
 * This Widget is placed within the [FeedScreen]'s [PageView].
 * It is composed of a [NetworkImage], [PartialProfileDetails],
 * a modal bottom sheet that contains [SlidingProfileDetails]
 * and a [LikeProfileButton].
 */

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
    return Stack(
      children: [
        SizedBox(
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
                padding: const EdgeInsets.all(leftRightPadding),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: radius20,
                        ),
                      ),
                      context: context,
                      builder: (context) =>
                          SlidingProfileDetails(profile: profile.userData),
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
