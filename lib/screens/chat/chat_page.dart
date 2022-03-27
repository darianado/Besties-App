import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:project_seg/models/User/UserMatch.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:intl/intl.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
import '../../constants/borders.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  final UserMatch userMatch;

  ChatScreen({
    required this.userMatch,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = new TextEditingController();

  //getMessages
  final FirestoreService _firestoreService = FirestoreService.instance;

  //create a message with sender and time and save it to firestore
  void _handleSubmitted(String content, String senderID, String matchID) {
    if (content.trim() == "") return;

    DateTime now = DateTime.now();
    Message message = Message(content: content, senderID: senderID, timestamp: now);

    _firestoreService.saveMessage(matchID, message);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final _contextState = Provider.of<ContextState>(context);
    final _matchState = Provider.of<MatchState>(context);

    print("There are ${widget.userMatch.messages?.length} messages to show for ${widget.userMatch.match?.fullName}");

    return Scaffold(
      backgroundColor: whiteColour,
      appBar: AppBar(
        backgroundColor: tertiaryColour,
        title: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () => context.pushNamed(matchProfileScreenName, extra: widget.userMatch, params: {pageParameterKey: chatScreenName}),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAlias,
                  child: CachedImage(url: widget.userMatch.match?.profileImageUrl),
                ),
                SizedBox(width: 10),
                Text(
                  widget.userMatch.match?.firstName ?? "",
                  style: Theme.of(context).textTheme.headline4?.apply(color: whiteColour),
                ),
              ],
            ),
          ),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: widget.userMatch.messages?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = widget.userMatch.messages![index];
                    return MessageWidget(message: message);
                  },
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: circularBorderRadius10,
                  border: Border.all(color: tertiaryColour),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: _textController,
                        decoration:
                            const InputDecoration(border: InputBorder.none, hintText: 'Message...', isCollapsed: true, counterText: ""),
                        minLines: 1,
                        maxLines: 10,
                        maxLength: _contextState.context?.maxChatMessageLength ?? 100,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _handleSubmitted(_textController.text, _userState.user!.user!.uid, widget.userMatch.matchID),
                      child: Text('Send', style: TextStyle(color: tertiaryColour, fontSize: 18)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context, listen: false);
    final bool isMine = (message.senderID == _userState.user?.userData!.uid);

    return Row(
      mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: isMine ? chatSenderColour : chatReceiverColour,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message.content!,
                style: TextStyle(
                  color: isMine ? whiteColour : primaryColour,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                message.messageTimestamp!,
                style: TextStyle(
                  color: isMine ? whiteColourShade3 : secondaryColour,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
