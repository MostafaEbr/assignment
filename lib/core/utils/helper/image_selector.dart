import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageSelector {
  factory ImageSelector() => _instance;

  ImageSelector._();

  static final _instance = ImageSelector._();

  final ImagePicker _picker = ImagePicker();

  // select single image
  Future<File?> showSelectImageDialog(
      {ImageSource source = ImageSource.gallery, int quality = 50}) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: source, imageQuality: quality);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

// select multiple images
  Future<List<File>?> showSelectImagesDialog({int quality = 50}) async {
    final List<XFile> pickedFiles =
        await _picker.pickMultiImage(imageQuality: quality);
    if (pickedFiles.isNotEmpty) {
      return pickedFiles.map((e) => File(e.path)).toList();
    }
    return null;
  }

  // select video
  Future<File?> showSelectVideoDialog(
      {ImageSource source = ImageSource.gallery}) async {
    final XFile? pickedFile = await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  // select multiple videos
  Future<List<File>?> showSelectVideosDialog(
      {ImageSource source = ImageSource.gallery}) async {
    final List<XFile> pickedFiles = await _picker.pickMultipleMedia();
    if (pickedFiles.isNotEmpty) {
      return pickedFiles.map((e) => File(e.path)).toList();
    }
    return null;
  }
}
