import 'package:flutter/material.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:intl/intl.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/textStyles.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import '../../constants/borders.dart';

class ChatScreen extends StatefulWidget {
  final String chatID;
  ChatScreen(this.chatID);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  //final firestore.FirebaseFirestore _firebaseFirestore = firestore.FirebaseFirestore.instance;
  
  TextEditingController _textController = TextEditingController();
  List<Message> _messages = [];

  Future<List<Message>> getMessages() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("chats").where(FieldPath.documentId, isEqualTo: widget.chatID).get();
    final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    if (chats.isEmpty){
      List<Message> messages = [];
      final newChat = {"messages" :  messages};
      FirebaseFirestore.instance.collection("chats").add(newChat);
    }else{
      Chat chat = chats[0];
      _messages = chat.messages;
    }
        return _messages;
  }

  void convertList() async {
    Future<List<Message>> messages = getMessages();
    _messages = await messages;
  }

  


  //create a message with sender and time and save it to firestore
  void _handleSubmitted(String text, String currentUser){
    convertList();
    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    _textController.clear();
    Message message = Message(time, currentUser, text, true);
    _messages.add(message);
    FirestoreService.instance.updateMessageList(widget.chatID, _messages);
    setState(() {
      _messages.insert(0, message);
    });
  }

  _messagebuilder(Message message) {
    Container msg = Container(
      margin: message.mine
          ? const EdgeInsets.only(top: 8, bottom: 8, left: 80)
          : const EdgeInsets.only(top: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.75,
      child: Flexible(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: message.mine ? kChatSenderColour : kChatReceiverColour,
            borderRadius: kSymmetricBorderRadius3,
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
                  hintText: "Send a message...", isCollapsed: true),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color: kSecondaryColour,
            onPressed: () {
              _handleSubmitted(_textController.text, currentUser.toString());
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    final _userState = Provider.of<UserState>(context);
    final currentUser = _userState.user?.user?.email;
    //convertList(widget.receiverEmail);
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
                  color: kSimpleWhiteColour,
                  borderRadius: kBorderRadiusTLeftTRight,
                ),
                child: ClipRRect(
                  borderRadius: kBorderRadiusTLeftTRight,
                  child: ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.only(top: 15),
                      itemCount: _messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Message message = _messages[index];
                        //_messages[index].setRead();
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
