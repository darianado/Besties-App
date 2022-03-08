import 'package:firebase_storage/firebase_storage.dart' as storage;

class StorageService {
  final storage.FirebaseStorage _firebaseStorage = storage.FirebaseStorage.instance;

  Future<String> getUrlForUserAvatar(String userId) async {
    String str = await _firebaseStorage.ref('users/$userId/profile_pic.png').getDownloadURL();

    print("STR: $str");

    return str;
  }
}
