import 'package:flutter/material.dart';
import 'package:project_seg/models/User/message_model.dart';



class ChatScreen extends StatefulWidget {
  //const ChatScreen({ Key? key }) : super(key: key);

  final User user = User ("","Current User", "assets/images/empty_profile_picture.jpg");

  ChatScreen({user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _messagebuilder(Message message, bool mine) {
    Container msg = Container(
      margin: mine
          ? EdgeInsets.only (top: 8, bottom: 8, left: 80)
          : EdgeInsets.only (top: 8, bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
          color: mine ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
          borderRadius: mine
              ? BorderRadius.only(
                  topLeft: Radius.circular(15), bottomLeft: Radius.circular(15))
              : BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            message.text,
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
     if (mine) {
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
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
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
            color: Theme.of(context).primaryColor,
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
                        return _messagebuilder(message, mine);
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
