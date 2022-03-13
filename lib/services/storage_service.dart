import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:image_picker/image_picker.dart';
import 'package:project_seg/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final storage.FirebaseStorage _firebaseStorage = storage.FirebaseStorage.instance;

  StorageService._privateConstructor();

  static final StorageService _instance = StorageService._privateConstructor();

  static StorageService get instance => _instance;

  Future<void> changeUserPhoto(String userId, File? image) async {
    print("Changing");

    if (image != null) {
      storage.ListResult imageRefs = await _firebaseStorage.ref('user_avatars/$userId').list(storage.ListOptions(maxResults: 5));
      imageRefs.items.forEach((element) {
        print("Deleting");
        element.delete();
      });

      File file = File(image.path);

      String ref = 'user_avatars/$userId/${Uuid().v4()}.png';

      print("This is the file ref: " + ref);

      storage.TaskSnapshot upload = await _firebaseStorage.ref(ref).putFile(file);

      String downloadUrl = await upload.ref.getDownloadURL();

      FirestoreService.instance.setProfileImageUrl(downloadUrl);
    }
  }
}
