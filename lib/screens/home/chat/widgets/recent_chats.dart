import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/images/cached_image.dart';
import 'package:project_seg/screens/components/images/circle_cached_image.dart';
import 'package:project_seg/screens/home/chat/chat_thread_screen.dart';
import 'package:project_seg/screens/home/chat/components/recent_chats_scroll_view.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class RecentChats extends StatelessWidget {
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
