import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Matches/user_match.dart';
import 'package:project_seg/models/Matches/message.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/components/circle_cached_image.dart';
import 'package:project_seg/screens/home/chat/components/chat_conversation.dart';
import 'package:project_seg/screens/home/chat/components/message_composer.dart';
import 'package:project_seg/screens/home/chat/components/message_widget.dart';
import 'package:project_seg/screens/home/chat/components/profile_app_bar_button.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:provider/provider.dart';

class ChatThreadScreen extends StatelessWidget {
  ChatThreadScreen({required this.userMatch});

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
                child: ChatConversation(context: context, userMatch: userMatch),
              ),
              SizedBox(height: 10),
              MesssageComposer(matchID: userMatch.matchID),
            ],
          ),
        ),
      ),
    );
  }
}
