import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/data/repositories/user/user_repository.dart';
import 'package:store/features/personalization/controllers/user_controller.dart';
import 'package:store/naviga_menu.dart';
import 'package:store/network_manager.dart';
import 'package:store/utils/constants/image_string.dart';
import 'package:store/utils/popups/fullscreen_loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeName();
  }

  Future<void> initializeName() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      // start loading
      FullScreenLoader.openLoadingDialog(
          'We are updating your information...', ImageString.docerAnimation);

      //check Internet
      final isConnected = await NetworkManager.instance.isConected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }
      
      // form validate
      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Update first name and last name in the firebase FireStore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim(),
      };
      
      await userRepository.updateSingleField(name);
      // Update Rx User value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
      
      // Remove loader
      FullScreenLoader.stopLoading();

      // Show mess
      Get.snackbar('Congratulation', "done");
      // Move to profile Screen
      Get.offAll(NavigationMenu());
    } catch (e) {
      rethrow;
    }
  }
}
