import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:store/data/repositories/categories/category_repository.dart';
import 'package:store/data/services/firebase_storage_service.dart';
import 'package:store/features/shop/models/category_model.dart';
import 'package:store/utils/storage/storage_utility.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final isLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final _db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    //loadDataFromLocalStorage();
    if (allCategories.isEmpty) {
      fetchCategories();
    }
  }

  /// Load data from local storage
  void loadDataFromLocalStorage() {
    print('load cate');
    final data = MyLocalStorage.instance().readData('allCategories');
    if (data != null) {
      allCategories.assignAll(
          (data as List).map((e) => CategoryModel.fromJson(e)).toList());
    }
    final featuredData =
        MyLocalStorage.instance().readData('featuredCategories');
    if (featuredData != null) {
      featuredCategories.assignAll((featuredData as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList());
    }
  }

  /// -- Fetch data from Database
  Future<void> fetchCategories() async {
    try {
      if (kDebugMode) {
        print('fetch cate');
      }
      // Show loader white loading categories
      isLoading.value = true;
      // Fetch categories from data source
      final categories = await _categoryRepository.getAllCategories();

      // Update the categories list
      allCategories.assignAll(categories);

      // filter feature categories
      featuredCategories.assignAll(allCategories.where((category) =>
          category.isFeatured == true && category.parentId.isEmpty));

      // final storage = MyLocalStorage.instance();
      // storage.writeData('allCategories',
      //     categories.map((element) => element.toJson()).toList());
      // storage.writeData('featuredCategories',
      //     featuredCategories.map((element) => element.toJson()).toList());
      // featuredCategories.assignAll(categories);
      // print(featuredCategories);
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  /// -- Load selected category data

  ///  Get Category or Sub- Category Products

  /// -- Upload Categories to the cloud firebase
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = Get.put(FirebaseStorageService());
      for (var category in categories) {
        // Get ImageData link from local assets
        final file = await storage.getImageDataFromAsset(category.image);
        // Upload image and Get its URL
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        // Assign Category in FireStore
        category.image = url;

        // Store Category in FireStore
        await _db
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } catch (e) {
      rethrow;
    }
  }
}
