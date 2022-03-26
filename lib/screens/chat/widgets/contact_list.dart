import 'package:project_seg/constants/borders.dart';
import 'package:project_seg/models/User/OtherUser.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/User/UserMatch.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:project_seg/router/route_names.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:project_seg/screens/components/cached_image.dart';
import 'package:project_seg/screens/chat/match_profile.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/colours.dart';

class Matches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _matchState = Provider.of<MatchState>(context);

    print("Number of matches: ${_matchState.matches?.length}");

    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _matchState.matches?.map((UserMatch e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Material(
                        borderRadius: BorderRadius.all(Radius.circular(1000)),
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(1000)),
                          onTap: () => context.pushNamed(matchProfileScreenName, extra: e, params: {pageParameterKey: chatScreenName}),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CachedImage(url: e.match!.profileImageUrl),
                          ),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        e.match!.firstName ?? "",
                        style: Theme.of(context).textTheme.subtitle1?.apply(fontWeightDelta: 2),
                      )
                    ],
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
