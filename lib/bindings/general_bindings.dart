import 'package:get/get.dart';
import 'package:store/data/repositories/user/user_repository.dart';
import 'package:store/features/personalization/controllers/user_controller.dart';
import 'package:store/features/shop/controllers/brand_controller.dart';
import 'package:store/features/shop/controllers/category_controller.dart';
import 'package:store/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(UserRepository());
    Get.put(NetworkManager());
    Get.put(CategoryController());
    Get.put(BrandController());
  }
}
