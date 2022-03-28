import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/User/UserMatch.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/home/chat/components/message_composer.dart';
import 'package:project_seg/screens/home/chat/components/message_widget.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({required this.userMatch});

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
                child: Conversation(context: context, userMatch: userMatch),
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

class Conversation extends StatelessWidget {
  final UserMatch userMatch;
  final BuildContext context;

  Conversation({Key? key, required this.userMatch, required this.context}) : super(key: key);

  @override
  Widget build(context) {
    final _ = Provider.of<MatchState>(context);

    return ListView.builder(
        reverse: true,
        itemCount: userMatch.messages?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final Message message = userMatch.messages![index];
          return MessageWidget(message: message);
        });
  }
}

class ProfileAppBarButton extends StatelessWidget {
  const ProfileAppBarButton({
    Key? key,
    required this.userMatch,
  }) : super(key: key);

  final UserMatch userMatch;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(5),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => context.pushNamed(matchProfileScreenName, extra: userMatch, params: {pageParameterKey: chatScreenName}),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(shape: BoxShape.circle),
              clipBehavior: Clip.antiAlias,
              child: CachedImage(url: userMatch.match?.profileImageUrl),
            ),
            SizedBox(width: 10),
            Text(
              userMatch.match?.firstName ?? "",
              style: Theme.of(context).textTheme.headline4?.apply(color: whiteColour),
            ),
          ],
        ),
      ),
    );
  }
}
