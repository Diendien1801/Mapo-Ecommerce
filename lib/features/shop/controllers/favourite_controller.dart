import 'dart:convert';

import 'package:get/get.dart';
import 'package:store/data/repositories/product/product_repository.dart';
import 'package:store/features/shop/models/product_model.dart';
import 'package:store/utils/storage/storage_utility.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find<FavouriteController>();

  final favourites = <String, bool>{}.obs;
  
  @override
  void onInit() {
    super.onInit();
    initFavourite();
  }

  Future<void> initFavourite() async {
    final json = await MyLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;

      favourites.assignAll(
        storedFavorites.map(
          (key, value) => MapEntry(key, value as bool),
        ),
      );
    }
  }

  bool isFavourite(String id) {
    return favourites[id] ?? false;
  }

  void toggleFavourite(String id) {
    if (!favourites.containsKey(id)) {
      favourites[id] = true;
      saveFavoritesToStorage();
      Get.snackbar('', 'Product has been added to Wishlist.');
    } else {
      MyLocalStorage.instance().removeData(id);
      favourites.remove(id);
      saveFavoritesToStorage();
      favourites.refresh();
      Get.snackbar('', 'Product has been removed from Wishlist.');
    }
  }

  void saveFavoritesToStorage() {
    final encodeFavorites = json.encode(favourites);
    MyLocalStorage.instance().writeData('favorites', encodeFavorites);
  }

  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance
        .getFavoriteProducts(favourites.keys.toList());
  }
}
