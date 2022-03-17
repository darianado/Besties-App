import 'package:flutter/material.dart';
import 'package:project_seg/models/User/message_model.dart';

import '../../constants.dart';



class ChatScreen extends StatefulWidget {
  //const ChatScreen({ Key? key }) : super(key: key);

  final User user = User ("","Current User", "assets/images/empty_profile_picture.jpg");

  ChatScreen({user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _messagebuilder(Message message) {
    Container msg = Container(
      margin: message.getMine()
          ? EdgeInsets.only (top: 8, bottom: 8, left: 80)
          : EdgeInsets.only (top: 8, bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.75,
      child: Flexible(
          child: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: message.getMine() ? kChatSenderColour : kChatReceiverColour,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message.text,
                    style: TextStyle(
                        color: kChatTextColour,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    message.time,
                    style: TextStyle(
                        color: kChatTimeColour,
                        fontSize: 10,
                        fontWeight: FontWeight.w600),
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
     if (message.getMine()) {
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
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          //if users are able to send messages
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: kSecondaryColour,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: "Send a message..."),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: kSecondaryColour,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          widget.user.name,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.only(top: 15),
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Message message = messages[index];
                        bool mine = message.sender.email == currentUser.email;
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
