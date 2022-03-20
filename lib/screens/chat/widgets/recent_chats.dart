import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/constants/textStyles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;


class GStyle {
    // 消息红点
    static badge({Color color = Colors.red, bool isdot = false, double height = 10.0, double width = 10.0}) {
        return Container(
            alignment: Alignment.center, height: !isdot ? height : height/2, width: !isdot ? width : width/2,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(100.0)),
            //child: !isdot ? Text('$_num', style: TextStyle(color: Colors.white, fontSize: 12.0)) : null
        );
    }
}

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            color: kChatList,
        ),
        child: ClipRRect(
          child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (BuildContext context, int index) {
                final Message chat = chats[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChatScreen(user: chat.senderEmail))
                          ),
                  child: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                chat.senderEmail,
                                style: kInactiveSliderStyle,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  chat.text,
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
                          if (chat.unread) GStyle.badge(),
                          Text(
                            chat.time,
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
            }
          ),
        ),
      ),
    );
  }
}