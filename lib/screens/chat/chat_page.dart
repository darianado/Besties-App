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

  List<Message> _messages = [];

  //getMessages
  final FirestoreService _firestoreService = FirestoreService.instance;

  /* Future<List<Message>> getMessages() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("chats").where(FieldPath.documentId, isEqualTo: widget.chatID).get();
    final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
      Chat chat = chats[0];
      List<Message> messageList = chat.messages;
      _messages = await messageList;
  }

  void convertList() async {
    Future<List<Message>> messages = getMessages();
    _messages = await messages;
  } */

  //create a message with sender and time and save it to firestore
  void _handleSubmitted(String content, String senderID, String receiverID) {
    DateTime now = DateTime.now();
    Message message = Message(senderID, content, now);

    _firestoreService.saveMessage(message, senderID, receiverID);
    //FirestoreService.instance.updateMessageList(widget.chatID, _messages);
    _textController.clear();

    setState(() {
      _messages.insert(0, message);
    });
  }

  _messageBuilder(Message message, BuildContext context) {
    final _userState = Provider.of<UserState>(context, listen: false);
    final bool isMine = (message.senderID == _userState.user?.userData!.uid);

    Container msg = Container(
      margin: isMine ? const EdgeInsets.only(top: 5, bottom: 5, left: 80) : const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isMine ? chatSenderColour : chatReceiverColour,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 3),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                message.content!,
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
                message.messageTimestamp!,
                style: TextStyle(
                  color: whiteColour,
                  fontSize: 10,
                ),
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
    if (isMine) {
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
                //_handleSubmitted(_textController.text, currentUser.toString());
              },
              child: Text('Send', style: TextStyle(color: tertiaryColour, fontSize: 18)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    return _messageBuilder(message, context);
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
