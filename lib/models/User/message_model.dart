import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;


class User {
  final String uid;
  final String name;
  final String imageUrl;

  User(this.uid, this.name, this.imageUrl);

}

class Message {
  String time; 
  String senderID;
  String text;
  bool mine;
  bool unread;

  Message (
    this.time, 
    this.senderID,
    this.text, 
    this.mine,
    this.unread,
    );

  factory Message.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();
    return Message(
      data?['time'], data?['senderID'], data?['text'], data?['mine'], data?['unread']
    );
  }
}


List<Message> chats = [];

/*   Future<List<Message>> getChats() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("messages").get();
    final chats = querySnapshot.docs.map((doc) => Message.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    return chats;
  }
  void convertMessage() async{
    chats =  await getChats();
  }

  Future<List<Message>> getContacts() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("messages").get();
    final chats = querySnapshot.docs.map((doc) => Message.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    return chats;
  }
  void convertContacts() async{
    chats =  await getContacts();
  }
 */


