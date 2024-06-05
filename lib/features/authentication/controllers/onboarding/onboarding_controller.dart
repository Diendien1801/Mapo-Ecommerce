import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/features/authentication/screens/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get to => Get.find<OnBoardingController>();

  final pageController = PageController();

  Rx<int> currentPageIndex = 0.obs;

  // Update Current Page Index when Page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;
  //Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage  = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    } 
  }
  void skipPage(){

  }
}
