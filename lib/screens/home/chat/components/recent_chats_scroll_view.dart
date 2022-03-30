import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/images/circle_cached_image.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

/**
 * This class represents the model of a reusable widget that is used
 * to display the chatting history of a user.
 */

class RecentChatsScrollView extends StatelessWidget {
  const RecentChatsScrollView({
    Key? key,
    required this.chats,
  }) : super(key: key);

  final List<UserMatch> chats;

  /**
   * This method builds a widget that displays all the chats of a user
   * sorted by the most recent message sent.
   */

  @override
  Widget build(BuildContext context) {
    chats.sort(
      (b, a) => a.messages!.first.timestamp!.compareTo(b.messages!.first.timestamp!),
    );
    return ListView(scrollDirection: Axis.vertical, children: chats.map((chat) => RecentChatsScrollViewItem(chat: chat)).toList());
  }
}

class RecentChatsScrollViewItem extends StatelessWidget {
  const RecentChatsScrollViewItem({
    Key? key,
    required this.chat,
  }) : super(key: key);

  final UserMatch chat;

  /**
   * This method builds a widget that displays a single chat in the list of recent chats.
   * It shows the picture and the name of the other user, as well as the most recent message.
   * If the user has not replied to a message, the "Reply" icon will be displayed.
   */

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
              CircleCachedImage(
                url: chat.match?.profileImageUrl,
                size: 70,
              ),
              const SizedBox(
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
                  ? const Icon(
                      FontAwesomeIcons.reply,
                      color: secondaryColour,
                      size: 24.0,
                    )
                  : const Text("")
            ],
          ),
        ),
      ),
    );
  }
}
