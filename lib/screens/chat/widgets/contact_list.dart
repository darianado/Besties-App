import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:project_seg/constants/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class Contacts extends StatelessWidget {


  List<Chat> chatList = [];

  Future<List<Chat>> getChats() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection(currentUser.toString()).get();
    final _contacts= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
    return _contacts;
  }

  void convertChat() async {
    Future<List<Chat>> _contacts = getChats();
    chatList = await _contacts;
  }

  @override
  Widget build(BuildContext context) {
    convertChat();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Your matched friends",
                  style: kContactListStyle,
                )
              ],
            ),
          ),
          Container(
            height: 120,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              itemCount: contacts.length,
              //itemCount: chatList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      //builder: (_) => ChatScreen(chatList[index].chatID)
                      builder: (_) => ChatScreen(contacts[index].email)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage:
                              AssetImage(contacts[index].imageUrl),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          contacts[index].name,
                          style: kContactListNamesStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}