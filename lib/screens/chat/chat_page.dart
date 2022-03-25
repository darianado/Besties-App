import 'package:flutter/material.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:intl/intl.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
import '../../constants/borders.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';



class ChatScreen extends StatefulWidget {
  final String chatID;
  ChatScreen(this.chatID);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = new TextEditingController();

  List<Message> _messages = [
/*     Message("currentUser", '1:00pm', 'Message 1', false, true),
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
    Message("firstUser", '1:00pm', 'Message 1', false, true), */
  ];

  Future<void> getMessages() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("chats").where(FieldPath.documentId, isEqualTo: widget.chatID).get();
    final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
      Chat chat = chats[0];
      List<Message> messageList = chat.messages;
      _messages = await messageList;
  }

  //create a message with sender and time and save it to firestore
  void _handleSubmitted(String text, String currentUser){
    DateTime now = DateTime.now();
    String time = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    _textController.clear();
    Message message = Message(time, currentUser, text, true, false);
    _messages.add(message);
    //FirestoreService.instance.updateMessageList(widget.chatID, _messages);
    setState(() {
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
          color: message.mine ? chatSenderColour : chatReceiverColour,
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
                style: TextStyle(
                  color: whiteColour,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.time,
                style:  TextStyle(
                  color: whiteColour,
                  fontSize: 10,
                ),
              ),
            ),
          ],
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

  _buildMessageComposer(String currentUser) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          borderRadius: circularBorderRadius10,
          border: Border.all(color: tertiaryColour),
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
                _handleSubmitted(_textController.text, currentUser);
              },
              child: Text('Send', style: TextStyle(color: tertiaryColour, fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    final _userState = Provider.of<UserState>(context);
    final currentUser = _userState.user?.user?.uid;
    return Scaffold(
      backgroundColor: whiteColour,
      appBar: AppBar(
        backgroundColor: tertiaryColour,
        title: Text(
          currentUser.toString(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,

        actions: [],
        /*  actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: kSimpleWhiteColour,
            onPressed: () {},
          )
        ], */
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: simpleWhiteColour,
                ),
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.only(top: 15),
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = _messages[index];
                    return _messagebuilder(message);
                  },
                ),
              ),
            ),
            _buildMessageComposer(currentUser.toString()),
          ],
        ),
      ),
    );
  }
}
