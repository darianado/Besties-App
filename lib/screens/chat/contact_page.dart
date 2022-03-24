import 'package:flutter/material.dart';
import 'package:project_seg/screens/chat/widgets/contact_list.dart';
import 'package:project_seg/screens/chat/widgets/recent_chats.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';
//import 'package:project_seg/models/User/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';






class Contact_Page extends StatefulWidget {
  const Contact_Page({Key? key}) : super(key: key);

  @override
  State<Contact_Page> createState() => _Contact_PageState();
}

class _Contact_PageState extends State<Contact_Page> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [0.4, 0.8, 1],
        colors: [
          whiteColour,
          whiteColourShade2,
          whiteColourShade3,
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
                          color: secondaryColour,
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
                          color: secondaryColour,
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
