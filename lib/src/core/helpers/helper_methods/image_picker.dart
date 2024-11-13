import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageSelector {
  static Future<File?> selectImage(ImageSource source)async {
    XFile? image = await ImagePicker().pickImage(source: source);
    if(image != null) {
      return File(image.path);
    }

    return null;
  }

  static Future<List<File>> getImages() async {
    final List<XFile> result = await ImagePicker().pickMultiImage();
    if (result.isNotEmpty) {
      List<File> files = result.map((e) => File(e.path)).toList();
      return files;
    } else {
      return List.empty();
    }
  }
}