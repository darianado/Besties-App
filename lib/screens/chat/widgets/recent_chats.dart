import 'package:project_seg/models/User/UserMatch.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:project_seg/constants/colours.dart';
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:project_seg/services/user_state.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/borders.dart';

class GStyle {
  static badge({Color color = Colors.red, bool isdot = false, double height = 10.0, double width = 10.0}) {
    return Container(
      alignment: Alignment.center,
      height: !isdot ? height : height / 2,
      width: !isdot ? width : width / 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: circularBorderRadius100,
      ),
    );
  }
}

class RecentChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _matchState = Provider.of<MatchState>(context);

    final _userState = Provider.of<UserState>(context);

    List<UserMatch>? chats = _matchState.activeChats;

    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: chats?.map((UserMatch chat) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => context.pushNamed(matchChatScreenName, extra: chat, params: {pageParameterKey: chatScreenName}),
                    child: Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CachedImage(url: chat.match!.profileImageUrl),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chat.match?.firstName ?? "",
                                  style: Theme.of(context).textTheme.headline6?.apply(fontWeightDelta: 2),
                                ),
                                Text(
                                  chat.mostRecentMessage?.content ?? "",
                                  style: Theme.of(context).textTheme.titleMedium,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
