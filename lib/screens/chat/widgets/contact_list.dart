import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/User/UserMatch.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:provider/provider.dart';

class Matches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _matchState = Provider.of<MatchState>(context);

    List<UserMatch>? matches = _matchState.matchesWithNoChat;

    return Container(
      width: double.infinity,
      child: (matches != null && matches.isNotEmpty)
          ? MatchesScrollView(matches: matches)
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  "No new matches yet...keep scrolling!.",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
    );
  }
}

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
        children: matches.map((match) => MatchesScrollViewItem(match: match)).toList(),
      ),
    );
  }
}

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
            borderRadius: BorderRadius.all(Radius.circular(1000)),
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(1000)),
              onTap: () => context.pushNamed(matchProfileScreenName, extra: match, params: {pageParameterKey: chatScreenName}),
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedImage(url: match.match!.profileImageUrl),
              ),
            ),
          ),
          SizedBox(height: 6),
          Text(
            match.match!.firstName ?? "",
            style: Theme.of(context).textTheme.subtitle1?.apply(fontWeightDelta: 2),
          )
        ],
      ),
    );
  }
}
