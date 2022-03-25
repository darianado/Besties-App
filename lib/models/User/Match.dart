import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/User/message_model.dart';

class Match {
  final UserData matchData;
  List<Message>? messages;

  Match({
    required this.matchData,
    this.messages,
  });
}
