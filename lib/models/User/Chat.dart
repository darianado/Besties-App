import 'package:project_seg/models/User/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class Chat {
  final List<Message> messages;
  final String chatID;

  Chat(this.chatID, this.messages);
  //final firestore.FirebaseFirestore _firebaseFirestore = firestore.FirebaseFirestore.instance;

  factory Chat.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();
    return Chat(doc.id, data?['messages'].cast<Message>());
  }

  List<String> getUsers() {
    List<String> _users = [];
    for (Message message in messages) {
      _users.add(message.senderEmail);
    }
    return _users;
  }
}

/* List<Chat> chatlist = [];

  Future<List<Chat>> getChats() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("Chats").get();
    final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    return chats;
  }

  void convertList() async {
    Future<List<Chat>> chat = getChats();
    List<Chat> chatlist = await chat;
  } */

/* Future<List<Chat>> getChats() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("Chats").get();
    final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    return chats;
  } */

List<Chat> chatlist = [];



  /* Future<List<Chat>> getRecentChats(String currentUser) async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("Chats").where(currentUser, whereIn: users).get();
    final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    return chats;
  }

  void convertList() async {
    Future<List<Chat>> chat = getRecentChats(currentUser.toString());
    List<Chat> chatlist = await chat;
  }

  Future<Chat> getChat(String currentUser, String receiver) async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("Chats").where(currentUser, whereIn: users).where(receiver, whereIn: users).limit(1).get();
    final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    Chat chat = chats[0];
    return chat;
  }

  Future<List<Message>> getUserMessages(String chatID) async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("Chats").where(FieldPath.documentId, isEqualTo: chatID).get();
    final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    Chat chat = chats[0];
    return chat.messages;
  }

  Future<Message> getMessage(String chatID) async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("Chats").where(FieldPath.documentId, isEqualTo: chatID).get();
    final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    Chat chat = chats[0];
    return chat.messages[0];
  }

  Future<Message> getMessagesWithUser(String currentUser, String receiver) async{
    Future<Chat> _chat = getChat(currentUser, receiver);
    Chat chat = await _chat;
    return chat.messages[0];
  }

  

  void convertMessage (String currentUser, String receiver) async{
    Future<Message> _message = getMessagesWithUser(currentUser, receiver);
    Message message = await _message;
  }

  



  void createChat(){
    List<Message> messages = [];
    final newChat = {
      "messages" :  messages,
    };
     _firebaseFirestore.collection("chats").add(newChat);
  } */
