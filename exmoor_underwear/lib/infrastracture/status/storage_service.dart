import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadMedia(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    try {
  var storageRef = await uploadTask.then((snapshot) {
    return snapshot.ref.getDownloadURL();
  });
  return storageRef;
} catch (e) {
  print("Storage Upload Hatası: $e");
  throw e;
}
  }
}
