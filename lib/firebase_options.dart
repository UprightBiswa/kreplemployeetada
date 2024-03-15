// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCS4LcsbOLdmkBt5o3BG-cWLaVyrfvo_J4',
    appId: '1:939941016475:web:9afffe90518f9dc9f7673e',
    messagingSenderId: '939941016475',
    projectId: 'kreplemployee',
    authDomain: 'kreplemployee.firebaseapp.com',
    storageBucket: 'kreplemployee.appspot.com',
    measurementId: 'G-3TXCPS12KL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCC-uy8QObsCn56Jd3iT2n6vHfzCt1Jy0',
    appId: '1:939941016475:android:ab39864c8182612cf7673e',
    messagingSenderId: '939941016475',
    projectId: 'kreplemployee',
    storageBucket: 'kreplemployee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAi9v01LVcV4nAuIa0Gy9jSrraSJEVT9oE',
    appId: '1:939941016475:ios:4a54a77731e4dd15f7673e',
    messagingSenderId: '939941016475',
    projectId: 'kreplemployee',
    storageBucket: 'kreplemployee.appspot.com',
    iosBundleId: 'com.example.kreplemployee',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAi9v01LVcV4nAuIa0Gy9jSrraSJEVT9oE',
    appId: '1:939941016475:ios:6ea116cfc82c3edaf7673e',
    messagingSenderId: '939941016475',
    projectId: 'kreplemployee',
    storageBucket: 'kreplemployee.appspot.com',
    iosBundleId: 'com.example.kreplemployee.RunnerTests',
  );
}