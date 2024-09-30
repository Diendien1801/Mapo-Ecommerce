import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:store/data/repositories/banners/banner_repository.dart';
import 'package:store/data/services/firebase_storage_service.dart';
import 'package:store/features/shop/models/banner_model.dart';
import 'package:store/utils/storage/storage_utility.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();
  // variable to store all banners
  final RxList<BannerModel> allBanners = <BannerModel>[].obs;
  // variable to store monthly banners
  final RxList<BannerModel> monthlyBanners = <BannerModel>[].obs;
  final bannerRepository = Get.put(BannerRepository());
  // variable to store current index of carousal
  var carousalCurrentIndex = 0.obs;

  void changeIndex(int index) {
    carousalCurrentIndex.value = index;
  }

  final _db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    loadDataFromLocalStorage();
    if (monthlyBanners.isEmpty) {
      fetchBanners();
    }
  }
  
  // Load data from local storage if available
  void loadDataFromLocalStorage() {
    
    final data = MyLocalStorage.instance().readData('monthlyBanners');
    if (data != null) {
      final banners = data.map((e) => BannerModel.fromJson(e)).toList();
      monthlyBanners.clear();
      for (var banner in banners) {
        monthlyBanners.add(banner);
      }
    }
  }

  // Fetch banners from the cloud firebase
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

      // Store categories in local storage -> fetch from firebase 1 time -> the second time it will be fetched from local storage
      MyLocalStorage.instance().writeData('monthlyBanners',
          monthlyBanners.map((element) => element.toJson()).toList());

      // featuredCategories.assignAll(categories);
      // print(featuredCategories);
    } catch (e) {
      rethrow;
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
      rethrow;
    }
  }
}
