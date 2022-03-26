import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class Message {
  String time;
  String senderEmail;
  String text;
  bool mine;
  bool unread;

  Message(
    this.time,
    this.senderEmail,
    this.text,
    this.mine,
    this.unread,
  );

  factory Message.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();
    return Message(data?['time'], data?['senderEmail'], data?['text'], data?['mine'], data?['unread']);
  }
}

/*
final User currentUser = User("0a4510a940ab4e7da7e2cfd415f79a97", "currentUser user", "assets/images/empty_profile_picture.jpg");
final User firstUser = User("011658af179b413fa23239a5bd2ae30c", "first user", "assets/images/empty_profile_picture.jpg");
final User secondUser = User("19a3285df1f24110bce7e02127964260", "second friend", "assets/images/empty_profile_picture.jpg");
final User thirdUser = User("33e8d598e5fd4685bd2a82fb4b631e77", "third friend", "assets/images/empty_profile_picture.jpg");
final User fourthUser = User("37cf8c6851434cd380c7160ff157f689", "fourth friend", "assets/images/empty_profile_picture.jpg");
final User fifthUser = User("4aabb3e342ca4498986246d750a14f70", "fifth friend", "assets/images/empty_profile_picture.jpg");
final User sixthUser = User("4c1c20e0a02d4f30aa2c0deba02b4b34", "sixth friend", "assets/images/empty_profile_picture.jpg");
*/
//List<User> contacts = [firstUser, secondUser, thirdUser, fourthUser, fifthUser, sixthUser];
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


