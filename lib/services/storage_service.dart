import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:uuid/uuid.dart';

class StorageService {
  final storage.FirebaseStorage _firebaseStorage = storage.FirebaseStorage.instance;

  StorageService._privateConstructor();
  static final StorageService _instance = StorageService._privateConstructor();

  static StorageService get instance => _instance;

  final profilePicturePrefix = "profile_pictures";

  Future<String?> changeUserPhoto(String userId, File? image) async {
    if (image != null) {
      const options = storage.ListOptions(maxResults: 5);

      storage.ListResult imageRefs = await _firebaseStorage.ref('$profilePicturePrefix/$userId').list(options);
      for (var element in imageRefs.items) {
        element.delete();
      }

      File file = File(image.path);

      String ref = '$profilePicturePrefix/$userId.png';

      storage.TaskSnapshot upload = await _firebaseStorage.ref(ref).putFile(file);

      return await upload.ref.getDownloadURL();
    }

    return null;
  }
}
