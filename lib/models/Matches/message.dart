import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String? content;
  String? senderID;
  DateTime? timestamp;

  Message({
    this.senderID,
    this.content,
    this.timestamp,
  });

  factory Message.fromSnapshot(DocumentSnapshot<Map> doc) {
    Map? data = doc.data();
    return Message(
      content: data?['content'],
      senderID: data?['senderID'],
      timestamp: (data?['timestamp'] as Timestamp).toDate(),
    );
  }

  String? get messageTimestamp {
    return "${timestamp?.day.toString().padLeft(2, '0')}/${timestamp?.month.toString().padLeft(2, '0')} ${timestamp?.hour.toString().padLeft(2, '0')}:${timestamp?.minute.toString().padLeft(2, '0')}";
  }

  Map<String, dynamic> toMap() {
    return {
      "content": content,
      "senderID": senderID,
      "timestamp": timestamp,
    };
  }
}
