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
    apiKey: 'AIzaSyAtRzBa-HmrCJuUdaqF-3eVePbi0vS-Wnk',
    appId: '1:110458463030:web:6d194310aa03d9a3e00997',
    messagingSenderId: '110458463030',
    projectId: 'flashcards-bb7c4',
    authDomain: 'flashcards-bb7c4.firebaseapp.com',
    storageBucket: 'flashcards-bb7c4.appspot.com',
    measurementId: 'G-HD77TP8R73',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARNFkW36V0WRZ-yRzSVxeaV863QS1cUoM',
    appId: '1:110458463030:android:ae5c15234833beace00997',
    messagingSenderId: '110458463030',
    projectId: 'flashcards-bb7c4',
    storageBucket: 'flashcards-bb7c4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNaUGqSV6NmSb9STvoakU3aPlv48o4Jvc',
    appId: '1:110458463030:ios:2743136b021081ebe00997',
    messagingSenderId: '110458463030',
    projectId: 'flashcards-bb7c4',
    storageBucket: 'flashcards-bb7c4.appspot.com',
    iosClientId: '110458463030-fkl9hi1hvpjb812l12h9h5b51dnbd1tb.apps.googleusercontent.com',
    iosBundleId: 'com.example.flashcards',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNaUGqSV6NmSb9STvoakU3aPlv48o4Jvc',
    appId: '1:110458463030:ios:2743136b021081ebe00997',
    messagingSenderId: '110458463030',
    projectId: 'flashcards-bb7c4',
    storageBucket: 'flashcards-bb7c4.appspot.com',
    iosClientId: '110458463030-fkl9hi1hvpjb812l12h9h5b51dnbd1tb.apps.googleusercontent.com',
    iosBundleId: 'com.example.flashcards',
  );
}
