import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FirebaseStorageService extends GetxController {
  static FirebaseStorageService get instance => Get.find();
  final _firebaseStorage = FirebaseStorage.instance;

  /// Upload Local Assets from IDE
  /// Return a Uint8List containing image data
  Future<Uint8List> getImageDataFromAsset(String path) async {
    try {
      //
      final byteData = await rootBundle.load(path);

      final imageData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      return imageData;
    } catch (e) {
      throw e;
    }
  }

  ///Upload image using ImageData on cloud Firebase Storage
  /// Returns the download URL of the uploaded image
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    try {
      //.ref -> tham chieu toi goc cua storage -> child -> tham chieu toi thu muc con 
      final ref = _firebaseStorage.ref().child(path).child(name);
      await ref.putData(image);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw e;
    }
  }
}
