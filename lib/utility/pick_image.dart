import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_seg/services/storage_service.dart';

class PickAndCropImage {
  final ImagePicker _picker = ImagePicker();

  Future<String?> pickImage(String uid) async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery, maxHeight: 800, maxWidth: 800, imageQuality: 90);
    if (file == null) return null;

    File? f = File(file.path);
    f = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1.5),
      aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
    );

    String? url = await StorageService.instance.changeUserPhoto(uid, f);
    return url;
  }
}
