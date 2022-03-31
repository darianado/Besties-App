import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as storage;

/// Collects methods related to Firebase Storage.
class StorageService {
  final storage.FirebaseStorage _firebaseStorage = storage.FirebaseStorage.instance;

  /// Singleton Service.
  StorageService._privateConstructor();
  static final StorageService _instance = StorageService._privateConstructor();
  static StorageService get instance => _instance;

  final profilePicturePrefix = "profile_pictures";

  /// Remove the old profile photo associated with the given [userID],
  /// and uploads a new [image] in place of the removed one.
  ///
  /// If the [image] is null, this method returns immediately.
  Future<String?> changeUserPhoto(String userID, File? image) async {
    if (image != null) {
      const options = storage.ListOptions(maxResults: 5);

      storage.ListResult imageRefs = await _firebaseStorage.ref('$profilePicturePrefix/$userID').list(options);
      for (var element in imageRefs.items) {
        element.delete();
      }

      File file = File(image.path);

      String ref = '$profilePicturePrefix/$userID.png';

      storage.TaskSnapshot upload = await _firebaseStorage.ref(ref).putFile(file);

      return await upload.ref.getDownloadURL();
    }

    return null;
  }
}
