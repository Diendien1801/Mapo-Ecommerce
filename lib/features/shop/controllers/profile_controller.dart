import 'package:get/get.dart';

class ProfileController extends GetxController {
  var safeMode = false.obs;

  static ProfileController get instance => Get.find();

  void changeMode() {
    safeMode = (!safeMode.value) as RxBool;
  }
}
