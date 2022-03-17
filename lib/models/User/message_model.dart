import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String name;
  final String imageUrl;

  User(this.email, this.name, this.imageUrl);
}

class Message {
  User sender;
  String time; 
  String text;
  bool unread;
  bool mine;

  Message (
    this.sender, 
    this.time, 
    this.text, 
    this.unread,
    this.mine,
    );

  bool getMine(){
    return mine;
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
  Message (secondUser, '1:00pm', "Message 1", false, true),
  Message (firstUser, '1:00pm', "Message 1", true, false),
  Message (firstUser, '1:00pm', "Message 1", true, false),
  Message (firstUser, '1:00pm', "Message 1", true, false),
  Message (firstUser, '1:00pm', "Message 1", true, true),
  Message (firstUser, '1:00pm', "Message 1", true, false),
];

List<Message> messages = [
  Message (currentUser, '1:00pm', 'Message 1', true , false),
  Message (firstUser, '1:00pm', 'Message 1', false, false),
  Message (currentUser, '1:00pm', 'Message 1', true, false),
  Message (firstUser, '1:00pm', 'Message 1', true, false),
  Message (currentUser, '1:00pm', 'Message 1', false, true),
  Message (firstUser, '1:00pm', 'Message 1', false, true),
  Message (currentUser, '1:00pm', 'Message 1', true, true),
  Message (firstUser, '1:00pm', 'Message 1', true, true),
  Message (currentUser, '1:00pm', 'Message 1', true, true),
  Message (firstUser, '1:00pm', 'Message 1', false, false),
  Message (currentUser, '1:00pm', 'Message 1', false, false),
  Message (firstUser, '1:00pm', 'Message 1', false, false),
];