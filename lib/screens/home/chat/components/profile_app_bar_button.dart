import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/screens/components/images/circle_cached_image.dart';

/**
 * This class represents a model of a reusable widget that is used
 * to create the app bar that is displayed in a chat page.
 */

class ProfileAppBarButton extends StatelessWidget {
  const ProfileAppBarButton({
    Key? key,
    required this.userMatch,
  }) : super(key: key);

  final UserMatch userMatch;

  /**
   * This method builds a widget that is displayed at the top of every chat.
   * It contains the picture and the first name of the user to chat with.
   */

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context.pushNamed(matchProfileScreenName,
            extra: userMatch, params: {pageParameterKey: chatScreenName}),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleCachedImage(
              url: userMatch.match?.profileImageUrl,
              size: 40,
            ),
            const SizedBox(width: 10),
            Text(
              userMatch.match?.firstName ?? "",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.apply(color: whiteColour),
            ),
          ],
        ),
      ),
    );
  }
}
