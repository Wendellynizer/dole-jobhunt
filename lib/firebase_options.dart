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
    apiKey: 'AIzaSyDSWtvqJ43JwqFdR1POkHpx9QNH-LhIJHU',
    appId: '1:907326974903:web:d2285cc848e44847069632',
    messagingSenderId: '907326974903',
    projectId: 'dole-jobhunt',
    authDomain: 'dole-jobhunt.firebaseapp.com',
    storageBucket: 'dole-jobhunt.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCuEnbDKNS0s5rESkUOXm2fQI5TkWQY2eY',
    appId: '1:907326974903:android:911abb43580e7bd0069632',
    messagingSenderId: '907326974903',
    projectId: 'dole-jobhunt',
    storageBucket: 'dole-jobhunt.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAFuanzQMjrrIP7Gss4DE-I9spQxSuVus8',
    appId: '1:907326974903:ios:e4a2520897bab2e1069632',
    messagingSenderId: '907326974903',
    projectId: 'dole-jobhunt',
    storageBucket: 'dole-jobhunt.firebasestorage.app',
    iosBundleId: 'com.example.doleJobhunt',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAFuanzQMjrrIP7Gss4DE-I9spQxSuVus8',
    appId: '1:907326974903:ios:e4a2520897bab2e1069632',
    messagingSenderId: '907326974903',
    projectId: 'dole-jobhunt',
    storageBucket: 'dole-jobhunt.firebasestorage.app',
    iosBundleId: 'com.example.doleJobhunt',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDSWtvqJ43JwqFdR1POkHpx9QNH-LhIJHU',
    appId: '1:907326974903:web:78e9af6c96049bde069632',
    messagingSenderId: '907326974903',
    projectId: 'dole-jobhunt',
    authDomain: 'dole-jobhunt.firebaseapp.com',
    storageBucket: 'dole-jobhunt.firebasestorage.app',
  );
}
