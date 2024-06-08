import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/data/repositories/user/user_repository.dart';
import 'package:store/features/authentication/screens/verify_email.dart';
import 'package:store/network_manager.dart';
import 'package:store/utils/constants/image_string.dart';
import 'package:store/utils/popups/fullscreen_loader.dart';
import 'package:store/features/authentication/models/user_model.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.find<SignupController>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final isCheck = false.obs;
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  void toggleCheck() {
    isCheck.value = !isCheck.value;
  }

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  Future<void> signUp() async {
    try {
      // start
      FullScreenLoader.openLoadingDialog(
          "We are processing your information...", ImageString.docerAnimation);
      // check Interner Connection
      final isConnected = await NetworkManager.instance.isConected();
      if (!isConnected) {
        Get.snackbar(
            "No Internet Connection", "Please check your internet connection");
        FullScreenLoader.stopLoading();
        return;
      }

      // Form validation   validate() help every validator in the form to run
      if (!signUpFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      //Check box to be checked / accept terms and conditions
      if (isCheck.value == false) {
        Get.snackbar(
            "Error", "Please accept the Privacy Policy and Terms of use");
        FullScreenLoader.stopLoading();
        return;
      }

      // Register user in the Firebase Authentication and Save user data in the firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      // Save Authenticated user in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: UserModel.generateUsername(firstName.text.trim()),
          email: email.text.trim(),
          phoneNumber: phone.text.trim(),
          profiePicture: '');
      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      FullScreenLoader.stopLoading();
      Get.to(
        () => VerifyEmailScreen(
          email: email.text.trim(),
        ),
      );
      Get.snackbar("Success", "User Registered Successfully");
    } catch (e) {
      Get.snackbar("Error", e.toString());
      FullScreenLoader.stopLoading();
    }
  }
}
