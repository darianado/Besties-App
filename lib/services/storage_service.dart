import 'package:firebase_storage/firebase_storage.dart' as storage;

class StorageService {
  final storage.FirebaseStorage _firebaseStorage = storage.FirebaseStorage.instance;

  StorageService._privateConstructor();

  static final StorageService _instance = StorageService._privateConstructor();

  static StorageService get instance => _instance;

  Future<String?> getUrlForUserAvatar(String userId) async {
    storage.ListResult imageRefs = await _firebaseStorage.ref('user_avatars/$userId').list(storage.ListOptions(maxResults: 5));

    if (imageRefs.items.isEmpty) {
      return null;
    }

    storage.Reference firstImageRef = imageRefs.items.first;

    String downloadUrl = await firstImageRef.getDownloadURL();

    print("Downloading URL: $downloadUrl");

    return downloadUrl;
  }
}
