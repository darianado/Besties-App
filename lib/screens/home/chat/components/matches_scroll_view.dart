import 'package:flutter/material.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/images/circle_cached_image.dart';

/// A widget that displays a list of [MatchesScrollViewItem] in a [SingleChildScrollView].
class MatchesScrollView extends StatelessWidget {
  const MatchesScrollView({
    Key? key,
    required this.matches,
  }) : super(key: key);

  final List<UserMatch> matches;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: matches
            .map((match) => MatchesScrollViewItem(match: match))
            .toList(),
      ),
    );
  }
}

/// A widget that displays a picture and name of the [match].
class MatchesScrollViewItem extends StatelessWidget {
  const MatchesScrollViewItem({
    Key? key,
    required this.match,
  }) : super(key: key);

  final UserMatch match;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Material(
            borderRadius: const BorderRadius.all(Radius.circular(1000)),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(1000)),
              onTap: () => context.pushNamed(matchProfileScreenName,
                  extra: match, params: {pageParameterKey: chatScreenName}),
              child: CircleCachedImage(
                url: match.match?.profileImageUrl,
                size: 90,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            match.match!.firstName ?? "",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.apply(fontWeightDelta: 2),
          )
        ],
      ),
    );
  }
}
