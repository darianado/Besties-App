import 'package:flutter/material.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:intl/intl.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/textStyles.dart';


class ChatScreen extends StatefulWidget {
  //const ChatScreen({ Key? key }) : super(key: key);


  ChatScreen({user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final firestore.FirebaseFirestore _firebaseFirestore = firestore.FirebaseFirestore.instance;
  String? currentUser = "";
  TextEditingController _textController = TextEditingController();
  List<Message> _messages = [];

  Future<List<Message>> getMessages() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("messages").where("sender", isEqualTo: currentUser.toString()).get();
    final messages = querySnapshot.docs.map((doc) => Message.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    return messages;
  }

  void convertMessage() async{
    _messages =  await getMessages();
  }

  void _handleSubmitted(String text){
    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    _textController.clear();
    Message message = Message(currentUser.toString(), time, text, true, false);
    final newMessage = {
        "sender": message.senderEmail,
        "time" : message.time,
        "text" : message.text,
        "unread" : message.unread,
        "mine" : message.mine,
      };
      _firebaseFirestore.collection("messages").add(newMessage);
    setState(() {
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
              borderRadius: const BorderRadius.all(Radius.circular(30)),
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
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 100,
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
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Send a message...",
                isCollapsed: true
              ),
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
  Widget build(BuildContext context){
    final _userState = Provider.of<UserState>(context);
    currentUser = _userState.user?.user?.email;
    convertMessage();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          currentUser.toString(),
          style: kChatAppBarStyle,
        ),
        elevation: 0.0,
       /*  actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          )
        ], */
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
                         _messages[index].setRead();
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
