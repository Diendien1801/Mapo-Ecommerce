import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/features/authentication/screens/login.dart';
import 'package:store/features/authentication/screens/onboarding.dart';
import 'package:store/features/authentication/screens/verify_email.dart';
import 'package:store/features/shop/controllers/order_controller.dart';
import 'package:store/naviga_menu.dart';
import 'package:store/utils/storage/storage_utility.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance =>
      Get.find<AuthenticationRepository>();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get authenticated User data
  // ignore: non_constant_identifier_names
  User? get AuthUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect(_auth.currentUser);
  }

  screenRedirect(User? user) async {
    final orderController = Get.put(OrderController());
    if (user != null) {
      if (user.emailVerified) {
        await MyLocalStorage.init(user.uid);
        await OrderController.instance.fetchOrders();
        Get.to(() => NavigationMenu());
      } else {
        Get.to(() => VerifyEmailScreen(email: _auth.currentUser!.email!));
      }
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.to(const LoginScreen())
          : Get.to(const Onboarding());
    }
  }

  /*  ------------------------- EMAIL AND PASSWORD SIGN IN ------------------ */
  /// [EmailAuthentication] - SignIn

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) {
    try {
      return _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// [EmailVeiification] - MAIL Verification
  Future<void> sendEmailVeirifycation() async {
    try {
      await _auth.currentUser!.sendEmailVerification(); // ho tro san
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// [EmailVeiification] - Forget password

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// [Logout] - Valid for any authentication
  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException {
      rethrow;
    } on FirebaseException {
      rethrow;
    } on FormatException {
      rethrow;
    } on PlatformException {
      rethrow;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}
