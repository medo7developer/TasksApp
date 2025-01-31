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
    apiKey: 'AIzaSyAQxA1bOBtQ6qoaBc_6BT4kkfh1lpPhnhU',
    appId: '1:1091812576148:web:b02f99b3489a2b0a595d81',
    messagingSenderId: '1091812576148',
    projectId: 'todoapp-80194',
    authDomain: 'todoapp-80194.firebaseapp.com',
    databaseURL: 'https://todoapp-80194-default-rtdb.firebaseio.com',
    storageBucket: 'todoapp-80194.appspot.com',
    measurementId: 'G-9YSDS28NHT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvPfvwHzndhROu8vxsYXngU2TmarIOet8',
    appId: '1:1091812576148:android:df90adab69246829595d81',
    messagingSenderId: '1091812576148',
    projectId: 'todoapp-80194',
    databaseURL: 'https://todoapp-80194-default-rtdb.firebaseio.com',
    storageBucket: 'todoapp-80194.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMB0q8chJ31gsc934FtnqAFeMkW3IedvA',
    appId: '1:1091812576148:ios:2d97d139a43fd610595d81',
    messagingSenderId: '1091812576148',
    projectId: 'todoapp-80194',
    databaseURL: 'https://todoapp-80194-default-rtdb.firebaseio.com',
    storageBucket: 'todoapp-80194.appspot.com',
    iosBundleId: 'com.example.todooapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMB0q8chJ31gsc934FtnqAFeMkW3IedvA',
    appId: '1:1091812576148:ios:2d97d139a43fd610595d81',
    messagingSenderId: '1091812576148',
    projectId: 'todoapp-80194',
    databaseURL: 'https://todoapp-80194-default-rtdb.firebaseio.com',
    storageBucket: 'todoapp-80194.appspot.com',
    iosBundleId: 'com.example.todooapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAQxA1bOBtQ6qoaBc_6BT4kkfh1lpPhnhU',
    appId: '1:1091812576148:web:3c3131c3c701a43c595d81',
    messagingSenderId: '1091812576148',
    projectId: 'todoapp-80194',
    authDomain: 'todoapp-80194.firebaseapp.com',
    databaseURL: 'https://todoapp-80194-default-rtdb.firebaseio.com',
    storageBucket: 'todoapp-80194.appspot.com',
    measurementId: 'G-K35DXPJRB2',
  );
}
