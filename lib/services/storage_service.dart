import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<String> uploadImage({
    required Uint8List file,
    required String firstSub,
    required String secondSub,
    required String fileName,
  }) async {
    var ref = _storage.ref(firstSub).child(secondSub).child(fileName);

    UploadTask upload = ref.putData(file);
    TaskSnapshot snap = await upload;
    String imageUrl = await snap.ref.getDownloadURL();
    return imageUrl;
  }
}
