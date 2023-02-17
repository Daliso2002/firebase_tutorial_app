import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? image = await imagePicker.pickImage(source: source);
  if (image != null) {
    return await image.readAsBytes();
  }
}

pickImages(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  final List<XFile> pickedFileList = await imagePicker.pickMultiImage();
  if (pickedFileList.isNotEmpty) {
    List<Uint8List> imageList = [];
    for (var image in pickedFileList) {
      var file = await image.readAsBytes();
      imageList.add(file);
    }

    return imageList;
  }
}
