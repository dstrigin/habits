// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCB7v7pMU0xehNyeT7DTqRiLjEOFQKr408',
    appId: '1:266360988049:android:86855b7e17113ad3267a30',
    messagingSenderId: '266360988049',
    projectId: 'habits-161e7',
    databaseURL: 'https://habits-161e7-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'habits-161e7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDE-VoH1erYataAbV32gtz_PVWmy0mOxQ8',
    appId: '1:266360988049:ios:d631f1a7b5c4248a267a30',
    messagingSenderId: '266360988049',
    projectId: 'habits-161e7',
    databaseURL: 'https://habits-161e7-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'habits-161e7.appspot.com',
    iosBundleId: 'com.example.habits',
  );
}
