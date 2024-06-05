// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC9L38_eivPE1iT1kqqAyQOOnR5h4OolOI',
    appId: '1:41645545718:web:75fc223ec5bb12960ff4d7',
    messagingSenderId: '41645545718',
    projectId: 'ecommercemapo',
    authDomain: 'ecommercemapo.firebaseapp.com',
    storageBucket: 'ecommercemapo.appspot.com',
    measurementId: 'G-1D7V2QZPQK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBy59ln70Drc9kI11JgBHBwGC9OrClWD9g',
    appId: '1:41645545718:android:a86803734a2b25730ff4d7',
    messagingSenderId: '41645545718',
    projectId: 'ecommercemapo',
    storageBucket: 'ecommercemapo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSXczd39z_7y6MgYqNladTAQpsoi8RzX0',
    appId: '1:41645545718:ios:e2ed3a7c99fe1ba20ff4d7',
    messagingSenderId: '41645545718',
    projectId: 'ecommercemapo',
    storageBucket: 'ecommercemapo.appspot.com',
    androidClientId: '41645545718-9hdci8tpj3h9dh2u09t2qd8np5iijn17.apps.googleusercontent.com',
    iosClientId: '41645545718-h9s4ufkqgd4kd97v12s1tfc9td4lf4b5.apps.googleusercontent.com',
    iosBundleId: 'com.example.store',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDSXczd39z_7y6MgYqNladTAQpsoi8RzX0',
    appId: '1:41645545718:ios:e2ed3a7c99fe1ba20ff4d7',
    messagingSenderId: '41645545718',
    projectId: 'ecommercemapo',
    storageBucket: 'ecommercemapo.appspot.com',
    androidClientId: '41645545718-9hdci8tpj3h9dh2u09t2qd8np5iijn17.apps.googleusercontent.com',
    iosClientId: '41645545718-h9s4ufkqgd4kd97v12s1tfc9td4lf4b5.apps.googleusercontent.com',
    iosBundleId: 'com.example.store',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC9L38_eivPE1iT1kqqAyQOOnR5h4OolOI',
    appId: '1:41645545718:web:54f5686e2bb4306e0ff4d7',
    messagingSenderId: '41645545718',
    projectId: 'ecommercemapo',
    authDomain: 'ecommercemapo.firebaseapp.com',
    storageBucket: 'ecommercemapo.appspot.com',
    measurementId: 'G-C83HYYP8VN',
  );

}