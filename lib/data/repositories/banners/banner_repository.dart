import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store/features/shop/models/banner_model.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  final _db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    fetchAllBanners();
  }

  Future<List<BannerModel>> fetchAllBanners() async {
    try {
      final snapshot = await _db.collection('Banners').get();
      final list = snapshot.docs
          .map((document) => BannerModel.fromSnapshot(document))
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
}
