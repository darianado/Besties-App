import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_seg/services/storage_service.dart';

class PickAndCropImage {
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickImage(String uid) async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery, maxHeight: 800, maxWidth: 800, imageQuality: 90);
    if (file == null) return null;

    File? f = await ImageCropper().cropImage(sourcePath: file.path,
        aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
        aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);

    return await StorageService.instance.changeUserPhoto(uid, f);
  }
}
