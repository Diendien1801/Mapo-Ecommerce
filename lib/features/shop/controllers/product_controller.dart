import 'package:get/get.dart';
import 'package:store/data/repositories/product/product_repository.dart';
import 'package:store/features/shop/models/product_model.dart';
import 'package:store/utils/storage/storage_utility.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  RxList<ProductModel> randomProducts = <ProductModel>[].obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> ikeaProduct = <ProductModel>[].obs;
  RxList<ProductModel> appleProduct = <ProductModel>[].obs;

  RxBool isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    loadDataFromLocalStorage();

    if (allProducts.isEmpty || ikeaProduct.isEmpty || appleProduct.isEmpty) {
      //fetchRandomProducts();
      fetchAllProducts();
    }

    super.onInit();
  }

  void loadDataFromLocalStorage() {
    final data = MyLocalStorage.instance().readData('allProducts');
    if (data != null) {
      allProducts.assignAll(
          (data as List).map((e) => ProductModel.fromJson(e)).toList());
    }
    final randomData = MyLocalStorage.instance().readData('randomProducts');
    if (randomData != null) {
      randomProducts.assignAll(
          (randomData as List).map((e) => ProductModel.fromJson(e)).toList());
    }
    final ikeaData = MyLocalStorage.instance().readData('ikeaProduct');
    if (ikeaData != null) {
      ikeaProduct.assignAll(
          (ikeaData as List).map((e) => ProductModel.fromJson(e)).toList());
    }
    final appleData = MyLocalStorage.instance().readData('appleProduct');
    if (appleData != null) {
      appleProduct.assignAll(
          (appleData as List).map((e) => ProductModel.fromJson(e)).toList());
    }

    print('ok');
  }

  Future<void> fetchRandomProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepository.getRandomProducts();

      randomProducts.assignAll(products);
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      final products = await productRepository.getAllProducts();
      allProducts.assignAll(products);

      ikeaProduct.assignAll(
          products.where((element) => element.brand == 'Ikea').toList());
      appleProduct.assignAll(
          products.where((element) => element.brand == 'Apple').toList());
      print("fetch");
      MyLocalStorage.instance().writeData('allProducts',
          allProducts.map((element) => element.toJson()).toList());
      MyLocalStorage.instance().writeData('ikeaProduct',
          ikeaProduct.map((element) => element.toJson()).toList());
      MyLocalStorage.instance().writeData('appleProduct',
          appleProduct.map((element) => element.toJson()).toList());
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
