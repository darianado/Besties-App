import 'package:flutter/material.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:intl/intl.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/textStyles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/borders.dart';

class ChatScreen extends StatefulWidget {
  //const ChatScreen({ Key? key }) : super(key: key);

  ChatScreen({user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = new TextEditingController();

  List<Message> _messages = [
    Message("currentUser", '1:00pm', 'Message 1', false, true),
    Message("firstUser", '1:00pm', 'Message 1', false, true),
    Message("currentUser", '1:00pm', 'Message 1', false, true),
    Message("firstUser", '1:00pm', 'Message 1', false, true),
    Message("currentUser", '1:00pm', 'Message 1', true, true),
    Message("firstUser", '1:00pm', 'Message 1', true, true),
    Message("currentUser", '1:00pm', 'Message 1', true, true),
    Message("firstUser", '1:00pm', 'Message 1', true, true),
    Message("currentUser", '1:00pm', 'Message 1', true, true),
    Message("firstUser", '1:00pm', 'Message 1', false, true),
    Message("currentUser", '1:00pm', 'Message 1', false, true),
    Message("firstUser", '1:00pm', 'Message 1', false, true),
  ];

  void _handleSubmitted(String text) {
    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    _textController.clear();
    Message message = new Message("current user", time, text, true, false);
    setState(() {
      //getMessages
      _messages.insert(0, message);
    });
  }

  _messagebuilder(Message message) {
    Container msg = Container(
      margin: message.mine ? const EdgeInsets.only(top: 5, bottom: 5, left: 80) : const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: message.mine ? kChatSenderColour : kChatReceiverColour,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                message.text,
                style: kChatTextStyle,
              ),
            ),
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.time,
                style: kChatTimeStyle,
              ),
            ),
          ],
        ),
      ),

      // decoration: BoxDecoration(
      //     color: mine ? kChatSenderColour : kTertiaryColour,
      //     borderRadius: mine
      //         ? BorderRadius.only(
      //             topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
      //         : BorderRadius.only(
      //             topRight: Radius.circular(15),
      //             bottomRight: Radius.circular(15))),
    );
    if (message.mine) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

  _buildMessageComposer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: circularBorderRadius10,
          border: Border.all(color: kTertiaryColour),
        ),
        child: Row(
          children: [
            //if users are able to send messages
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                controller: _textController,
                decoration: const InputDecoration(border: InputBorder.none, hintText: 'Message...', isCollapsed: true),
              ),
            ),
            TextButton(
              onPressed: () {
                _handleSubmitted(_textController.text);
              },
              child: Text('Send', style: TextStyle(color: kTertiaryColour, fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final currentUser = _userState.user?.user?.email;
    return Scaffold(
      backgroundColor: kWhiteColour,
      appBar: AppBar(
        backgroundColor: kTertiaryColour,
        title: Text(
          currentUser.toString(),
          style: kChatAppBarStyle,
        ),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: kSimpleWhiteColour,
            onPressed: () {},
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: kSimpleWhiteColour,
                ),
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(top: 15),
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = _messages[index];
                    _messages[index].setRead();
                    return _messagebuilder(message);
                  },
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
