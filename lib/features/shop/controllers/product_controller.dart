import 'package:get/get.dart';
import 'package:store/data/repositories/product/product_repository.dart';
import 'package:store/features/shop/models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  RxList<ProductModel> randomProducts = <ProductModel>[].obs;
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> ikeaProduct = <ProductModel>[].obs;
  RxList<ProductModel> appleProduct = <ProductModel>[].obs;

  final productRepository = Get.put(ProductRepository());
  @override
  void onInit() {
    fetchRandomProducts();
    fetchAllProducts();
    super.onInit();
  }

  Future<void> fetchRandomProducts() async {
    try {
      final products = await productRepository.getRandomProducts();

      randomProducts.assignAll(products);
    } catch (e) {
    } finally {}
  }

  Future<void> fetchAllProducts() async {
    try {
      final products = await productRepository.getAllProducts();
      allProducts.assignAll(products);
      randomProducts.assignAll(products);
      ikeaProduct.assignAll(
          products.where((element) => element.brand == 'Ikea').toList());
      appleProduct.assignAll(
          products.where((element) => element.brand == 'Apple').toList());
    } catch (e) {
    } finally {}
  }
}
