import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] 
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
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
    apiKey: 'AIzaSyBJQ1Dprg-EIeQ60RPclgKtxuNtbWuws2Y',
    appId: '1:16624933945:web:a1b2c3d4e5f6g7h8i9j0k1',
    messagingSenderId: '16624933945',
    projectId: 'smartmoney-57583',
    authDomain: 'smartmoney-57583.firebaseapp.com',
    storageBucket: 'smartmoney-57583.firebasestorage.app',
    measurementId: 'G-XXXXXXXXXX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJQ1Dprg-EIeQ60RPclgKtxuNtbWuws2Y',
    appId: '1:16624933945:android:7dd060968ac498f6b641e8',
    messagingSenderId: '16624933945',
    projectId: 'smartmoney-57583',
    storageBucket: 'smartmoney-57583.firebasestorage.app',
  );

}