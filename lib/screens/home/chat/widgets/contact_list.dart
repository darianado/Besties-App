import 'package:flutter/material.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/screens/home/chat/components/matches_scroll_view.dart';
import 'package:project_seg/states/match_state.dart';
import 'package:provider/provider.dart';

/**
 * This class is used to store the matches of a user before a chat is initiated.
 */

class Matches extends StatelessWidget {
  const Matches({Key? key}) : super(key: key);

  /**
   * This method builds a widget that displays all the matches that have not started
   * a chat in a horizontal row.
   * If no matches are available yet, the text "No new matches yet... Keep scrolling!"
   * is displayed.
   */

  @override
  Widget build(BuildContext context) {
    final _matchState = Provider.of<MatchState>(context);

    List<UserMatch>? matches = _matchState.matchesWithNoChat;

    return SizedBox(
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
