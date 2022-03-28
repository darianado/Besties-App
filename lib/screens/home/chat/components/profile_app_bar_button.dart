import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/screens/components/images/circle_cached_image.dart';

class ProfileAppBarButton extends StatelessWidget {
  const ProfileAppBarButton({
    Key? key,
    required this.userMatch,
  }) : super(key: key);

  final UserMatch userMatch;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context.pushNamed(matchProfileScreenName, extra: userMatch, params: {pageParameterKey: chatScreenName}),
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
              style: Theme.of(context).textTheme.headline4?.apply(color: whiteColour),
            ),
          ],
        ),
      ),
    );
  }
}
