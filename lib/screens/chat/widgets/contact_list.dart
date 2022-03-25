import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:provider/provider.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:intl/intl.dart';

import '../../../constants/colours.dart';

final User firstUser = User ("011658af179b413fa23239a5bd2ae30c", "first user", "assets/images/empty_profile_picture.jpg");
final User secondUser = User ("19a3285df1f24110bce7e02127964260", "second friend", "assets/images/empty_profile_picture.jpg");
final User thirdUser = User ("33e8d598e5fd4685bd2a82fb4b631e77", "third friend", "assets/images/empty_profile_picture.jpg");
final User fourthUser = User ("37cf8c6851434cd380c7160ff157f689", "fourth friend", "assets/images/empty_profile_picture.jpg");
final User fifthUser = User ("4aabb3e342ca4498986246d750a14f70", "fifth friend", "assets/images/empty_profile_picture.jpg");
final User sixthUser = User ("4c1c20e0a02d4f30aa2c0deba02b4b34", "sixth friend", "assets/images/empty_profile_picture.jpg");

List<User> contacts = [firstUser, secondUser, thirdUser, fourthUser, fifthUser, sixthUser];


class Contacts extends StatelessWidget {
  String chatID = '';

  Future<List<Chat>> getChats() async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chats')
          .get();
      final chats = querySnapshot.docs
          .map((doc) =>
              Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>))
          .toList();
      return chats;
    }

  Future<void> findChat(String currentUser, String recevierID) async {
      List<Chat> chats = await getChats();
      for (Chat chat in chats){
        if(chat.getUsers().contains(currentUser) && chat.getUsers().contains(recevierID) ){
          chatID = chat.chatID;
          break;
        }
      }
      if(chatID==''){
        DateTime now = DateTime.now();
        String time = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
        Message message = Message(time, currentUser, "Hello, i am your friend. We can start chat now", true, false);
        List<Message> _messages = [];
        _messages.add(message);
        FirebaseFirestore.instance.collection("chats").add({"messages": _messages});
      }
    }

  
  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final currentUser = _userState.user?.user?.uid;
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
              final String receiverID = contacts[index].uid;
              findChat(currentUser.toString(), receiverID);
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatScreen(chatID))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage(contacts[index].imageUrl),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        contacts[index].name,
                        style: TextStyle(
                          color: kTertiaryColour,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
