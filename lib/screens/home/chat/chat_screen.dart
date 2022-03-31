import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/other_user.dart';
import 'package:project_seg/screens/home/chat/components/left_aligned_headline.dart';
import 'package:project_seg/screens/home/chat/widgets/contact_list.dart';
import 'package:project_seg/screens/home/chat/widgets/recent_chats.dart';
import 'package:project_seg/states/match_state.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/**
 * The screen that displays the page with user's the matches and conversations.
 *
 * The matches are arranged chronologically in a horizontal row at the top of
 * the screen, under the "New matches" text.
 * All the chats are displayed under the "Chats" section.
 */

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<OtherUser>? matches;

  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  /**
   * This asyncronous method fetches all the user's matches.
   */
  void fetchMatches() async {
    final _matchState = Provider.of<MatchState>(context, listen: false);
    final _userState = Provider.of<UserState>(context, listen: false);
    _matchState.onStart(_userState.user!.user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.4, 0.8, 1],
          colors: [
            whiteColour,
            whiteColourShade2,
            whiteColourShade3,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(
              child: SafeArea(
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: LeftAlignedHeadline(text: "New matches"),
                      ),
                    ),
                    Matches(),
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5),
                      child: LeftAlignedHeadline(text: "Chats"),
                    ),
                    RecentChats()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
