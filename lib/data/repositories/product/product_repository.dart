import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store/data/services/firebase_storage_service.dart';
import 'package:store/features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => ProductRepository();
  final _db = FirebaseFirestore.instance;

  /// Get limidted featured products
  Future<List<ProductModel>> getRandomProducts() async {
    try {
      final random = Random();
      final snapshot = await _db.collection('Products').get();
      final products = snapshot.docs;
      products.shuffle(random);
      final randomProducts = products.take(8).toList();
      return randomProducts
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  // Get data rely on brand name
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();

      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      final list =
          snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      print(list);
      return list;
    } on FirebaseException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw e;
    }
  }

  /// Upload dummy date to the Cloud Firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {
    try {
      // Upload all the produts along with their images
      final storage = Get.put(FirebaseStorageService());

      for (var product in products) {
        // Get ImageData link from local assets
        final file = await storage.getImageDataFromAsset(product.image);
        // Upload image and Get its URL
        final url = await storage.uploadImageData('Products', file, product.id);

        // Assign Category in FireStore
        product.image = url;

        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    } catch (e) {
      throw e;
    } finally {}
  }
}
