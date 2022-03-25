import 'package:project_seg/models/User/OtherUser.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/models/User/Chat.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:project_seg/screens/home/profile/match_profile.dart';
import 'package:project_seg/services/match_state.dart';
import 'package:provider/provider.dart';

import '../../../constants/colours.dart';

class Matches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _matchState = Provider.of<MatchState>(context);

    print("Number of matches: ${_matchState.matches?.length}");
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _matchState.matches?.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MatchProfileScreen())),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      /*
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage(content![index].userData.profileImageUrl!),
                      ),
                      */
                      const SizedBox(height: 6),
                      Text(
                        _matchState.matches?[index] ?? "NA",
                        style: TextStyle(
                          color: tertiaryColour,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
