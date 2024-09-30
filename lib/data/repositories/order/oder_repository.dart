import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/features/shop/models/order_model.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  Future<List<OrderModel>> getOrders() async {
    // Fetch orders from API
    try {
      final snapshot = await _db.collection('Orders').get();
      final tempList = snapshot.docs
          .map((document) => OrderModel.fromSnapshot(document))
          .toList();

      final list = tempList
          .where((element) =>
              element.userId == AuthenticationRepository.instance.AuthUser!.uid)
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

  Future<void> uploadOrder(OrderModel order) async {
    // Upload order to the API
    try {
      await _db.collection('Orders').add(order.toJson());
    } on FirebaseException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
