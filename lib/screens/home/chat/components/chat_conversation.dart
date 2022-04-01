import 'package:flutter/material.dart';
import 'package:project_seg/models/Matches/message.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/screens/home/chat/components/message_widget.dart';
import 'package:project_seg/states/match_state.dart';
import 'package:provider/provider.dart';

/// A widget that displays a conversation between a user and their match.
class ChatConversation extends StatelessWidget {
  final UserMatch userMatch;
  final BuildContext context;

  const ChatConversation(
      {Key? key, required this.userMatch, required this.context})
      : super(key: key);

  @override
  Widget build(context) {
    final _ = Provider.of<MatchState>(context);

    return ListView.builder(
      reverse: true,
      itemCount: userMatch.messages?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final Message message = userMatch.messages![index];
        return MessageWidget(message: message);
      },
    );
  }
}
