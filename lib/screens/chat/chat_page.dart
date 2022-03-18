import 'package:flutter/material.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:intl/intl.dart';
import '../../constants/constant.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/constants/colours.dart';



class ChatScreen extends StatefulWidget {
  //const ChatScreen({ Key? key }) : super(key: key);


  ChatScreen({user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = new TextEditingController();
  
  List<Message> _messages = [
  Message ("currentUser", '1:00pm', 'Message 1', false),
  Message ("firstUser", '1:00pm', 'Message 1', false),
  Message ("currentUser", '1:00pm', 'Message 1', false),
  Message ("firstUser", '1:00pm', 'Message 1', false),
  Message ("currentUser", '1:00pm', 'Message 1', true),
  Message ("firstUser", '1:00pm', 'Message 1', true),
  Message ("currentUser", '1:00pm', 'Message 1', true),
  Message ("firstUser", '1:00pm', 'Message 1', true),
  Message ("currentUser", '1:00pm', 'Message 1', true),
  Message ("firstUser", '1:00pm', 'Message 1', false),
  Message ("currentUser", '1:00pm', 'Message 1', false),
  Message ("firstUser", '1:00pm', 'Message 1', false),
];

void _handleSubmitted(String text){
  DateTime now = DateTime.now();
  String time = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  _textController.clear();
  Message message = new Message("current user", time, text, true);
  setState(() {
    //getMessages
    _messages.insert(0, message);
  });
}

  _messagebuilder(Message message) {
    Container msg = Container(
      margin: message.mine
          ? const EdgeInsets.only (top: 8, bottom: 8, left: 80)
          : const EdgeInsets.only (top: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.75,
      child: Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: message.mine ? kChatSenderColour : kChatReceiverColour,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message.text,
                    style: kChatTextStyle,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
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

 _builMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          //if users are able to send messages
          IconButton(
            icon: const Icon(Icons.photo),
            iconSize: 25.0,
            color: kSecondaryColour,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(hintText: "Send a message..."),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color: kSecondaryColour,
            onPressed: () {
              _handleSubmitted(_textController.text);
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final _userState = Provider.of<UserState>(context);
    final currentUser = _userState.user?.user?.email;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          currentUser.toString(),
          style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.only(top: 15),
                      itemCount: _messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Message message = _messages[index];
                        return _messagebuilder(message);
                      }),
                ),
              ),
            ),
            _builMessageComposer()
          ],
        ),
      ),
    );
  }
}
