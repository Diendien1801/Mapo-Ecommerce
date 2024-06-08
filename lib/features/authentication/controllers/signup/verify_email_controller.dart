import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/features/authentication/screens/succes_screen.dart';
import 'package:store/utils/constants/image_string.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance =>
      Get.find<VerifyEmailController>();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  /// Send Email Verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVeirifycation();
      Get.snackbar("Success",
          "Verification link sent to your email. Please verify your email to continue.");
    } on FirebaseAuthException catch (e) {
      throw e;
    } on FirebaseException catch (e) {
      throw e;
    } on FormatException catch (e) {
      throw e;
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Timer to automaticallly redirect on Email Verication
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.offAll(() => SuccessScreen(
              image: ImageString.bannerImage1,
              title: 'Email Verified',
              subTitle: 'Your email has been verified successfully.',
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(user),
            ));
      }
    });
  }

  /// Manually Check if Email Verified

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
            image: '',
            title: 'Email Verified',
            subTitle: 'Your email has been verified successfully.',
            onPressed: () =>
                AuthenticationRepository.instance.screenRedirect(currentUser),
          ));
    }
  }
}
