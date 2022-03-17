import 'package:flutter/material.dart';
import 'package:project_seg/screens/chat/widgets/contact_list.dart';
import 'package:project_seg/screens/chat/widgets/recent_chats.dart';
import 'package:project_seg/constants.dart';


class Contact_Page extends StatefulWidget {
  const Contact_Page({ Key? key }) : super(key: key);

  @override
  State<Contact_Page> createState() => _Contact_PageState();
}

class _Contact_PageState extends State<Contact_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTertiaryColour,
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Column(
                children: <Widget>[
                  Contacts(),
                  RecentChats()
                ],
              ),
            ),
        ],
      ),
    );
  }
}
