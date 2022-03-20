import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;


class User {
  final String email;
  final String name;
  final String imageUrl;

  User(this.email, this.name, this.imageUrl);

  String getName(){
    return name.toString();
  }
}

class Message {

  String senderEmail;
  //String receiverEmail;
  String time; 
  String text;
  bool unread;
  bool mine;

  Message (
    this.senderEmail, 
    //this.receiverEmail,
    this.time, 
    this.text, 
    this.mine,
    this.unread,
    );

  factory Message.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();
    return Message(
      data?['sender'], data?['time'], data?['text'], data?['mine'], data?['unread'],
    );
  }

  void setRead(){
    unread = false; 
  }

}



final User currentUser = User ("","Current User", "assets/images/empty_profile_picture.jpg");
final User firstUser = User ("", "second friend", "assets/images/empty_profile_picture.jpg");
final User secondUser = User ("", "first friend", "assets/images/empty_profile_picture.jpg");
final User thirdUser = User ("", "first friend", "assets/images/empty_profile_picture.jpg");
final User fourthUser = User ("", "first friend", "assets/images/empty_profile_picture.jpg");
final User fifthUser = User ("", "first friend", "assets/images/empty_profile_picture.jpg");
final User sixthUser = User ("", "first friend", "assets/images/empty_profile_picture.jpg");

List<User> contacts = [firstUser, secondUser, thirdUser, fourthUser, fifthUser, sixthUser];
List<Message> chats = [];

  Future<List<Message>> getChats() async{
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



