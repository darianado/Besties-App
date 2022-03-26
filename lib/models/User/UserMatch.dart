import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/User/message_model.dart';

class UserMatch {
  String matchID;
  UserData? match;
  DateTime? timestamp;
  List<Message>? messages;

  UserMatch({required this.matchID, this.match, this.timestamp, this.messages});

  factory UserMatch.fromMatchSnapshot(DocumentSnapshot<Map> doc, String userID) {
    Map? data = doc.data();
    final _matchUserID = List<String>.from(data?['uids']).firstWhere((element) => element != userID);
    return UserMatch(
      matchID: doc.id,
      match: UserData(uid: _matchUserID),
      timestamp: (data?['timestamp'] as Timestamp).toDate(),
    );
  }
}
