import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/UserMatch.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/cached_image.dart';
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
          ? ChatsScrollView(chats: chats)
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

class ChatsScrollView extends StatelessWidget {
  const ChatsScrollView({
    Key? key,
    required this.chats,
  }) : super(key: key);

  final List<UserMatch> chats;

  @override
  Widget build(BuildContext context) {
    chats.sort(
      (b, a) => a.messages!.first.timestamp!.compareTo(b.messages!.first.timestamp!),
    );
    return ListView(scrollDirection: Axis.vertical, children: chats.map((chat) => ChatsScrollViewItem(chat: chat)).toList());
  }
}

class ChatsScrollViewItem extends StatelessWidget {
  const ChatsScrollViewItem({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final UserMatch chat;

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context, listen: false);
    final bool isMine = (chat.mostRecentMessage!.senderID == _userState.user?.userData!.uid);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.pushNamed(matchChatScreenName, extra: chat, params: {pageParameterKey: chatScreenName}),
        child: Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: CachedImage(url: chat.match!.profileImageUrl),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.match?.firstName ?? "",
                      style: Theme.of(context).textTheme.headline6?.apply(fontWeightDelta: 2),
                    ),
                    Text(
                      chat.mostRecentMessage?.content ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              !isMine
                  ? Icon(
                      FontAwesomeIcons.reply,
                      color: secondaryColour,
                      size: 24.0,
                    )
                  : Text("")
            ],
          ),
        ),
      ),
    );
  }
}
