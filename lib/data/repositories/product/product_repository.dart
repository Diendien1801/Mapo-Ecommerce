import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Get data rely on brand name
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _db.collection('Products').get();

      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc))
          .toList();
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Get data with limit
  Future<List<ProductModel>> getProductsWithLimit({int limit = 10, String? lastId}) async {
    try {
      Query query = _db.collection('Products').limit(limit);

      if (lastId != null) {
        DocumentSnapshot lastDocument = await _db.collection('Products').doc(lastId).get();
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => ProductModel.fromSnapshot(doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
  

  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productIds) async {
    if (productIds.isEmpty) {
      // Trả về danh sách rỗng nếu productIds rỗng
      return [];
    }
    try {
      // Lấy danh sách sản phẩm từ productIds 
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      final list =
          snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      if (kDebugMode) {
        print(list);
      }

      return list;
    } on FirebaseException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
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
      rethrow;
    } finally {}
  }
}
