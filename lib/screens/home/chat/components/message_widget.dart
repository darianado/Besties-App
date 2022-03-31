import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/models/Matches/message.dart';
import 'package:project_seg/states/user_state.dart';
import 'package:provider/provider.dart';

/**
 * This class represents a model of a reusable widget that is used
 * to display a message that appears in the conversation.
 */

class MessageWidget extends StatelessWidget {
  final Message message;

  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  /**
   * This method builds a widget that is used to display the messages
   * used in the communication between two users.
   * The widget displays the content of the message and the time it is sent.
   */

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final bool isMine = (message.senderID == _userState.user?.user?.uid);

    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: isMine ? chatSenderColour : chatReceiverColour,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
