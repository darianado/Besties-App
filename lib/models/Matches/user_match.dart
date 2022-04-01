import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/models/Matches/message.dart';
import 'package:project_seg/models/User/user_data.dart';

/// A [UserMatch]
class UserMatch {
  String matchID;
  UserData? match;
  DateTime? timestamp;
  List<Message>? messages;

  /// Orders the messages by timestamp.
  set messagesOrdered(List<Message>? newMessages) {
    newMessages?.sort((a, b) {
      final aTimestamp = a.timestamp;
      final bTimestamp = b.timestamp;

      if (aTimestamp != null && bTimestamp != null) {
        return bTimestamp.compareTo(aTimestamp);
      } else {
        return 0;
      }
    });

    messages = newMessages;
  }

  UserMatch({required this.matchID, this.match, this.timestamp, this.messages});

  /// This factory creates an instance of [UserMatch] from a [DocumentSnapshot].
  factory UserMatch.fromSnapshot(DocumentSnapshot<Map> doc, String userID) {
    Map? data = doc.data();
    final _matchUserID = List<String>.from(data?['uids'])
        .firstWhere((element) => element != userID);
    return UserMatch(
      matchID: doc.id,
      match: UserData(uid: _matchUserID),
      timestamp: (data?['timestamp'] as Timestamp).toDate(),
    );
  }

  /// Gets the most recent message.
  Message? get mostRecentMessage {
    return messages?.first;
  }
}
