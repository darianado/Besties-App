import 'package:flutter/material.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/screens/home/chat/components/recent_chats_scroll_view.dart';
import 'package:project_seg/states/match_state.dart';
import 'package:provider/provider.dart';

class RecentChats extends StatelessWidget {
  const RecentChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _matchState = Provider.of<MatchState>(context);

    List<UserMatch>? chats = _matchState.activeChats;

    return Expanded(
      child: (chats != null && chats.isNotEmpty)
          ? RecentChatsScrollView(chats: chats)
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  "You haven't started any chats yet.",
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
    );
  }
}
