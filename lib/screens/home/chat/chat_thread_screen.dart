import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/screens/home/chat/components/chat_conversation.dart';
import 'package:project_seg/screens/home/chat/components/message_composer.dart';
import 'package:project_seg/screens/home/chat/components/profile_app_bar_button.dart';

/// A widget that displays the chat between two users.
///
/// The page contains the [ProfileAppBarButton] providing information about the
/// user to chat with, the messages send between users and
/// the [MessageComposer] where the user can write a message to be sent.
class ChatThreadScreen extends StatelessWidget {
  const ChatThreadScreen({Key? key, required this.userMatch}) : super(key: key);

  final UserMatch userMatch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColour,
      appBar: AppBar(
        backgroundColor: tertiaryColour,
        title: ProfileAppBarButton(userMatch: userMatch),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            children: [
              Expanded(
                child: ChatConversation(userMatch: userMatch),
              ),
              const SizedBox(height: 10),
              MessageComposer(matchID: userMatch.matchID),
            ],
          ),
        ),
      ),
    );
  }
}
