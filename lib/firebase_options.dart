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
    apiKey: 'AIzaSyDP4FTT4xoAyBwN9iIzCVvsG8kYGLCW3vw',
    appId: '1:392979995972:web:dedf6cd40f1f770e1c0b11',
    messagingSenderId: '392979995972',
    projectId: 'hackathon-app-untitled',
    authDomain: 'hackathon-app-untitled.firebaseapp.com',
    storageBucket: 'hackathon-app-untitled.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAA4qqcqPbm1dg5-QHuMcxSJmfMs7u4PEg',
    appId: '1:392979995972:android:589483136ac3ecbb1c0b11',
    messagingSenderId: '392979995972',
    projectId: 'hackathon-app-untitled',
    storageBucket: 'hackathon-app-untitled.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCECHTnb9sszTvijCGqGwdhCtdmdgh4O9Q',
    appId: '1:392979995972:ios:cec4f9161a9954c01c0b11',
    messagingSenderId: '392979995972',
    projectId: 'hackathon-app-untitled',
    storageBucket: 'hackathon-app-untitled.appspot.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCECHTnb9sszTvijCGqGwdhCtdmdgh4O9Q',
    appId: '1:392979995972:ios:cec4f9161a9954c01c0b11',
    messagingSenderId: '392979995972',
    projectId: 'hackathon-app-untitled',
    storageBucket: 'hackathon-app-untitled.appspot.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDP4FTT4xoAyBwN9iIzCVvsG8kYGLCW3vw',
    appId: '1:392979995972:web:0e2b9fa668ae22061c0b11',
    messagingSenderId: '392979995972',
    projectId: 'hackathon-app-untitled',
    authDomain: 'hackathon-app-untitled.firebaseapp.com',
    storageBucket: 'hackathon-app-untitled.appspot.com',
  );

}