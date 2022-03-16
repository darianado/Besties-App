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

  Message (
    this.sender, 
    this.time, 
    this.text, 
    this.unread
    );
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
  Message (secondUser, '1:00pm', "Message 1", false),
  Message (firstUser, '1:00pm', "Message 1", true),
  Message (firstUser, '1:00pm', "Message 1", true),
  Message (firstUser, '1:00pm', "Message 1", true),
  Message (firstUser, '1:00pm', "Message 1", true),
  Message (firstUser, '1:00pm', "Message 1", true),
];

List<Message> messages = [
  Message (currentUser, '1:00pm', 'Message 1', true),
  Message (firstUser, '1:00pm', 'Message 1', true),
  Message (currentUser, '1:00pm', 'Message 1', true),
  Message (firstUser, '1:00pm', 'Message 1', true),
  Message (currentUser, '1:00pm', 'Message 1', false),
  Message (firstUser, '1:00pm', 'Message 1', false),
  Message (currentUser, '1:00pm', 'Message 1', true),
  Message (firstUser, '1:00pm', 'Message 1', true),
  Message (currentUser, '1:00pm', 'Message 1', true),
  Message (firstUser, '1:00pm', 'Message 1', false),
  Message (currentUser, '1:00pm', 'Message 1', false),
  Message (firstUser, '1:00pm', 'Message 1', false),
  Message (currentUser, '1:00pm', 'Message 1', true),
  Message (firstUser, '1:00pm', 'Message 1', true),
  Message (currentUser, '1:00pm', 'Message 1', false),
  Message (firstUser, '1:00pm', 'Message 1', false),
];