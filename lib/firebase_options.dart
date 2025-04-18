// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDFmSFV5a4Kzy0MwqTENPfFM-sesjw1aDQ',
    appId: '1:770351379165:web:f2f1e467f922d0c6c9e134',
    messagingSenderId: '770351379165',
    projectId: 'clima-app-ad266',
    authDomain: 'clima-app-ad266.firebaseapp.com',
    storageBucket: 'clima-app-ad266.firebasestorage.app',
    measurementId: 'G-CJKQLRSRGB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1cCN7qBNGRAeJSMpwY5dLgEexkCKgH1M',
    appId: '1:770351379165:android:8e828723c8b01b67c9e134',
    messagingSenderId: '770351379165',
    projectId: 'clima-app-ad266',
    storageBucket: 'clima-app-ad266.firebasestorage.app',
  );
}
