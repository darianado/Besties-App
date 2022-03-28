import 'package:flutter/material.dart';
import 'package:project_seg/constants/borders.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Matches/message.dart';
import 'package:project_seg/services/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

class MesssageComposer extends StatelessWidget {
  final String matchID;

  TextEditingController _textController = new TextEditingController();
  final FirestoreService _firestoreService = FirestoreService.instance;

  MesssageComposer({
    Key? key,
    required this.matchID,
  }) : super(key: key);

  //create a message with sender and time and save it to firestore
  void _handleSend(String content, String? senderID) {
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

    return Container(
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
              decoration: const InputDecoration(border: InputBorder.none, hintText: 'Message...', isCollapsed: true, counterText: ""),
              minLines: 1,
              maxLines: 10,
              maxLength: _contextState.context?.maxChatMessageLength ?? 100,
            ),
          ),
          TextButton(
            onPressed: () {
              _handleSend(_textController.text, _userState.user?.user?.uid);
            },
            child: Text('Send', style: TextStyle(color: tertiaryColour, fontSize: 18)),
          )
        ],
      ),
    );
  }
}
