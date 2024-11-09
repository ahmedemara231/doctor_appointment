import 'dart:io';

import 'package:file_picker/file_picker.dart';

class MyFilePicker{
  static void pick({bool? allowMultiply})async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiply?? false,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
    } else {
      // User canceled the picker
    }
  }

  static void save()async{
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Please select an output file:',
      fileName: 'output-file.pdf',
    );

    if (outputFile == null) {
      // User canceled the picker
    }
  }
}