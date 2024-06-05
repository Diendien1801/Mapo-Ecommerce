import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:store/data/repositories/brand/brand_repository.dart';
import 'package:store/features/shop/models/brand_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();
  final _repository = Get.put(BrandRepository());

  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchAllBrands();
  }

  Future<void> fetchAllBrands() async {
    try {
      final brands = await _repository.getAllBrand();
      allBrands.assignAll(brands);
      featuredBrands.assignAll(
          brands.where((element) => element.isFeatured == true).toList());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
