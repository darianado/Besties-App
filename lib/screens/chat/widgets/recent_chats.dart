import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/textStyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';

import '../../../constants/borders.dart';

class GStyle {
  // 消息红点
  static badge(
      {Color color = Colors.red,
      bool isdot = false,
      double height = 10.0,
      double width = 10.0}) {
    return Container(
      alignment: Alignment.center, height: !isdot ? height : height / 2,
      width: !isdot ? width : width / 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: kCircularBorderRadius100,
      ),
      //child: !isdot ? Text('$_num', style: TextStyle(color: Colors.white, fontSize: 12.0)) : null
    );
  }
}

class RecentChats extends StatelessWidget {
  final List<Chat> chatList;

  RecentChats(this.chatList);

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final currentUser = _userState.user?.user?.email;

    List<Chat> chatlist = [];

    Future<List<Chat>> getChats() async {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(currentUser.toString())
          .get();
      final chats = querySnapshot.docs
          .map((doc) =>
              Chat.fromSnapshot(doc as firestore.DocumentSnapshot<Map>))
          .toList();
      return chats;
    }

    void convertList() async {
      Future<List<Chat>> chat = getChats();
      chatlist = await chat;
    }

    convertList();

    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: kChatList,
        ),
        child: ClipRRect(
          child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                final Chat chat = chatlist[index];
                String receiverEmail = chat.chatID;
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatScreen(receiverEmail)),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: kSymmetricBorderRadius2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  chat.chatID,
                                  style: kInactiveSliderStyle,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    chat.messages[0].text,
                                    style: kInactiveSliderStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            //if (message.unread) GStyle.badge(),
                            Text(
                              chat.messages[0].time,
                              style: kUnreadTextStyle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
