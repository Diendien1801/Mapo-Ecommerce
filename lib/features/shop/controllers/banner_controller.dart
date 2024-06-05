import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:store/data/repositories/banners/banner_repository.dart';
import 'package:store/data/services/firebase_storage_service.dart';
import 'package:store/features/shop/models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  final RxList<BannerModel> allBanners = <BannerModel>[].obs;
  final RxList<BannerModel> monthlyBanners = <BannerModel>[].obs;
  final bannerRepository = Get.put(BannerRepository());
  var carousalCurrentIndex = 0.obs;

  void changeIndex(int index) {
    carousalCurrentIndex.value = index;
  }

  final _db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      // Fetch categories from data source
      final banners = await bannerRepository.fetchAllBanners();

      // Update the categories list
      allBanners.assignAll(banners);

      // filter feature categories
      final random = Random();
      final selectedBanners = allBanners.toList()..shuffle(random);
      monthlyBanners.assignAll(selectedBanners.take(3));
      // featuredCategories.assignAll(categories);
      // print(featuredCategories);
    } catch (e) {
      throw e;
    }
  }

  // Upload banners to the cloud firebase
  Future<void> uploadDummyData(List<BannerModel> banners) async {
    try {
      final storage = Get.put(FirebaseStorageService());
      for (var banner in banners) {
        // Get ImageData link from local assets
        final file = await storage.getImageDataFromAsset(banner.image);
        // Upload image and Get its URL  // need name to be unique
        final url = await storage.uploadImageData('Banners', file, banner.id);

        // Assign Category in FireStore
        banner.image = url;

        // Store Category in FireStore
        await _db.collection('Banners').doc(banner.id).set(banner.toJson());
      }
    } catch (e) {
      throw e;
    }
  }
}
