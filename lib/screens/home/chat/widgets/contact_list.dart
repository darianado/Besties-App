import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';
import 'package:project_seg/screens/components/images/circle_cached_image.dart';
import 'package:project_seg/screens/home/chat/chat_thread_screen.dart';
import 'package:project_seg/screens/home/chat/components/matches_scroll_view.dart';
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
                  "No new matches yet... Keep scrolling!",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
    );
  }
}
