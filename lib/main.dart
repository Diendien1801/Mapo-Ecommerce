import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store/bindings/general_bindings.dart';
import 'package:store/data/repositories/authentication/authentication_repository.dart';
import 'package:store/features/authentication/screens/onboarding.dart';
import 'package:store/firebase_options.dart';
import 'package:store/utils/theme/theme.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  /// -- GetX local Storage
  await GetStorage.init();
   /// -- Await Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- Initialized Firebase && Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home: Onboarding(),
    );
  }
}
