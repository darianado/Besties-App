import 'package:flutter/material.dart';
import 'package:project_seg/screens/chat/widgets/contact_list.dart';
import 'package:project_seg/screens/chat/widgets/recent_chats.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/textStyles.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;


class Contact_Page extends StatefulWidget {
  const Contact_Page({ Key? key }) : super(key: key);

  @override
  State<Contact_Page> createState() => _Contact_PageState();
}

class _Contact_PageState extends State<Contact_Page> {
  List<Chat> chatslist = [];


  @override
  Widget build(BuildContext context) {

    final _userState = Provider.of<UserState>(context);
    final currentUser = _userState.user?.user?.email;

    List<Chat> _chats = [];

    Future<void> getChats() async{
      QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection("chats").get();
      final chats= querySnapshot.docs.map((doc) => Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>)).toList();
      for ( Chat chat in chats) {
        if(chat.getUsers().contains(currentUser.toString())){
          _chats.add(chat);
        }
      }
    }

  getChats();

    return Scaffold(
      backgroundColor: kContactList,
      appBar: AppBar(
        backgroundColor: kContactList,
        title: Text(
          'Your conversations',
          style: kChatAppBarStyle,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Column(
                children: <Widget>[
                  Contacts(),
                  RecentChats(_chats)
                ],
              ),
            ),
        ],
      ),
    );
  }
}
