import 'package:flutter/material.dart';
import 'package:project_seg/screens/chat/widgets/contact_list.dart';
import 'package:project_seg/screens/chat/widgets/recent_chats.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';



class Contact_Page extends StatefulWidget {
  const Contact_Page({Key? key}) : super(key: key);

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

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.4, 0.8, 1],
        colors: [
          kWhiteColour,
          kWhiteColourShade2,
          kWhiteColourShade3,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            Expanded(
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Matches',
                            style: TextStyle(
                          color: kSecondaryColour,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        )),
                      ),
                    ),
                    Contacts(),
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Chats', style: TextStyle(
                          color: kSecondaryColour,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        )),
                      ),
                    ),
                    RecentChats()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
