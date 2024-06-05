import 'package:get/get.dart';
import 'package:store/data/repositories/user/user_repository.dart';
import 'package:store/features/authentication/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());

  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = true.obs;

  @override
  void onInit() {
    fetchUserRecord();
    super.onInit();
  }

  // Fetch User Record
  Future<void> fetchUserRecord() async {
    try {
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {}
  }
}
