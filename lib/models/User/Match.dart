import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/User/message_model.dart';

class UserMatch {
  final String? matchUserID;
  final DateTime? timestamp;

  UserMatch({
    this.matchUserID,
    this.timestamp,
  });

  factory UserMatch.fromSnapshot(DocumentSnapshot<Map> doc, String userID) {
    Map? data = doc.data();

    final _matchUserID = List<String>.from(data?['uids']).firstWhere((element) => element != userID);

    return UserMatch(
      matchUserID: _matchUserID,
      timestamp: (data?['timestamp'] as Timestamp).toDate(),
    );
  }
}
