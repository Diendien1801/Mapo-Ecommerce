import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/features/authentication/screens/send_resest_email_done.dart';
import 'package:store/network_manager.dart';
import 'package:store/utils/constants/image_string.dart';
import 'package:store/utils/popups/fullscreen_loader.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordformKey = GlobalKey<FormState>();

  // Send Reset password email
  sendPasswordResetEmail() async {
    try {
      // Start loading

      FullScreenLoader.openLoadingDialog(
          "Processing your request...", ImageString.docerAnimation);

      // Check internet connection
      final isConected = await NetworkManager.instance.isConected();
      if (!isConected) {
        FullScreenLoader.stopLoading();
        return;
      }
      // Form validate
      if (!forgetPasswordformKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }
      // Send password reset email

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      // remove Loader
      FullScreenLoader.stopLoading();
      // Show success message
      Get.snackbar('Email Sent', 'ok');

      // Redirect to login
      Get.offAll(() => SendEmailDone());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Get.snackbar('Error', e.toString());
    }
  }

  // Resend
  resendPasswordResetEmail() async {}
}
