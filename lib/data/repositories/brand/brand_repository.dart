import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store/data/services/firebase_storage_service.dart';
import 'package:store/features/shop/models/brand_model.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Get all brand
  Future<List<BrandModel>> getAllBrand() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final list = snapshot.docs
          .map((document) => BrandModel.fromSnapshot(document))
          .toList();

      return list;
    } on FirebaseException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /// Upload All brand to the Cloud Firebase
  Future<void> uploadDummyData(List<BrandModel> brands) async {
    try {
      // Upload all the produts along with their images
      final storage = Get.put(FirebaseStorageService());

      for (var brand in brands) {
        // Get ImageData link from local assets
        final file = await storage.getImageDataFromAsset(brand.image);
        // Upload image and Get its URL
        final url = await storage.uploadImageData('Brands', file, brand.id);

        // Assign Category in FireStore
        brand.image = url;

        await _db.collection('Brands').doc(brand.id).set(brand.toJson());
      }
    } catch (e) {
      throw e;
    } finally {}
  }
}
