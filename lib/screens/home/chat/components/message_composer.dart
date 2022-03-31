import 'package:flutter/material.dart';
import 'package:project_seg/constants/borders.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Matches/message.dart';
import 'package:project_seg/states/context_state.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/**
 * This class represents a model of a reusable widget that is used
 * to create a message in order to be sent by the user.
 */

class MessageComposer extends StatefulWidget {
  final String matchID;

  MessageComposer({
    Key? key,
    required this.matchID,
  }) : super(key: key);

  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  final TextEditingController _textController = TextEditingController();

  late final FirestoreService _firestoreService;

  @override
  void initState() {
    super.initState();
    _firestoreService = Provider.of<FirestoreService>(context, listen: false);
  }

  /**
   * This method creates a message to be sent.
   * The content and the time it is sent is saved to the database.
   * After the message is sent, the _textController is cleared.
   * @param String content - the content of the message
   * @param String? senderID - the ID of the user that sent the message
   */

  void _handleSend(String content, String? senderID) {
    if (content.trim() == "") return;

    DateTime now = DateTime.now();
    Message message =
        Message(content: content, senderID: senderID, timestamp: now);

    _firestoreService.saveMessage(widget.matchID, message);
    _textController.clear();
  }
  /**
   * This method builds a widget that is used to sent new messages in the chat.
   * By defalut, "Message..." is displayed.
   * The "Send" button allows user to send their messages.
   */

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final _contextState = Provider.of<ContextState>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
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
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Message...',
                  isCollapsed: true,
                  counterText: ""),
              minLines: 1,
              maxLines: 10,
              maxLength: _contextState.context?.maxChatMessageLength ?? 100,
            ),
          ),
          TextButton(
            onPressed: () {
              _handleSend(_textController.text, _userState.user?.user?.uid);
            },
            child: const Text(
              'Send',
              style: TextStyle(color: tertiaryColour, fontSize: 18),
            ),
          )
        ],
      ),
    );
  }
}
