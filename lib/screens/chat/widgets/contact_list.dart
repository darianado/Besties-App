import 'package:project_seg/models/User/message_model.dart';
import 'package:project_seg/screens/chat/chat_page.dart';
import 'package:flutter/material.dart';

import '../../../constants/colours.dart';

class Contacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contacts.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatScreen(user: contacts[index]))),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage(contacts[index].imageUrl),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        contacts[index].name,
                        style: TextStyle(
                          color: kTertiaryColour,
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
