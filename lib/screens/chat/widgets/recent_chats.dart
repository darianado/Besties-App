import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:project_seg/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:project_seg/constants/colours.dart';


class RecentChats extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _userState = Provider.of<UserState>(context);
    final userUrl = _userState.user?.user?.photoURL;

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
                          builder: (_) => ChatScreen(user: chat.senderEmail))),
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20),
                    )
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
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          //chat.unread ? GStyle.badge(true) : Text(''),
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