import 'package:flutter/material.dart';
import 'package:project_seg/screens/chat/widgets/contact_list.dart';
import 'package:project_seg/screens/chat/widgets/recent_chats.dart';
import 'package:project_seg/constants.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';


class Contact_Page extends StatefulWidget {
  const Contact_Page({ Key? key }) : super(key: key);

  @override
  State<Contact_Page> createState() => _Contact_PageState();
}

class _Contact_PageState extends State<Contact_Page> {
  @override
  Widget build(BuildContext context) {

    final _userState = Provider.of<UserState>(context);
    final currentUser = _userState.user?.user;

    return Scaffold(
      backgroundColor: kContactList,
      appBar: AppBar(
        backgroundColor: kContactList,
        title: Text(
          'Your conversations',
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
