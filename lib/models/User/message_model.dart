import 'package:cloud_firestore/cloud_firestore.dart';


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
  final _firestore = FirebaseFirestore.instance;

  void getMessages() async {
    final messages = await _firestore.collection('messages').get();
    for (var message in messages.docs){
      print(message.data());
    }
  }

  String senderEmail;
  //String receiverEmail;
  String time; 
  String text;
  //bool unread;
  bool mine;

  Message (
    this.senderEmail, 
    //this.receiverEmail,
    this.time, 
    this.text, 
    //this.unread,
    this.mine,
    );

  String getMessageText(){
    return text;
  }

  void setMessageText(String messageText){
    this.text = messageText;
  }

  String getMessageUser(){
    return senderEmail;
  }

  String getMessageTime(){
    return time;
  }

  void setMessageTime(String time){
    this.time = text;
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

List<Message> chats = [
  Message ("secondUser", '1:00pm', "Message 1", true),
  Message ("firstUser", '1:00pm', "Message 1",  false),
  Message ("firstUser", '1:00pm', "Message 1", false),
  Message ("firstUser", '1:00pm', "Message 1", false),
  Message ("firstUser", '1:00pm', "Message 1", true),
  Message ("firstUser", '1:00pm', "Message 1", false),
];

