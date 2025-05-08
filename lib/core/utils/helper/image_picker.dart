import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickImage {
  static Future<File?> cameraPick() async {
    var cameraImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (cameraImage != null) {
      return File(cameraImage.path);
    }
    return null;
  }

  static Future<File?> galleryPick() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      final andriodInfo = await DeviceInfoPlugin().androidInfo;
      if (andriodInfo.version.sdkInt <= 32) {
        status = await Permission.storage.request();
      } else {
        status = await Permission.photos.request();
      }
    } else {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        return File(image.path);
      } else {
        return null;
      }
    }
    return null;
  }
}
