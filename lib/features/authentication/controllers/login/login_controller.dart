import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/features/shop/controllers/product_controller.dart';
import 'package:store/network_manager.dart';
import 'package:store/utils/constants/image_string.dart';
import 'package:store/utils/popups/fullscreen_loader.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find<LoginController>();

  final rememberMe = false.obs;
  final hidePassword = false.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onInit() {
    super.onInit();
    // Check if Remember Me is checked
    if (localStorage.read('REMEMBER_ME_EMAIL') != null) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      password.text = localStorage.read('REMEMBER_ME_PASSWORD');
      rememberMe.value = true;
    }
  }

  void toggleRemember() {
    rememberMe.value = !rememberMe.value;
  }

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  /// -- Email and Password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
          'Logging you in...', ImageString.docerAnimation);
      // Check Internet Connection
      final isConnected = await NetworkManager.instance.isConected();
      if (!isConnected) {
        Get.snackbar(
            'No Internet Connection', 'Please check your internet connection');
        return;
      }

      // Form validation
      if (!formKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save data if Remember Me is checked
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // Login user in the Firebase Authentication
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect(userCredential.user);
    } on FirebaseAuthException catch (e) {
      FullScreenLoader.stopLoading();

      if (e.code == 'invalid-credential') {
        Get.snackbar(
            'Try again', 'Your account does not exist. Please sign up first.');
      }
      if (e.code == 'user-not-found') {
        Get.snackbar('Try again', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Try again', 'Wrong password provided for that user.');
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Get.snackbar('Try Again', "Something went wrong");
    }
  }
}
