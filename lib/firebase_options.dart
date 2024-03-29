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

  // static const FirebaseOptions android = FirebaseOptions(
  //   apiKey: 'AIzaSyByj9DBlX5vIy_oO3tkqyRRh6LEgxVTdKc',
  //   appId: '1:970811725126:android:7719770e4bb71778e60147',
  //   messagingSenderId: '970811725126',
  //   projectId: 'sarfapp-62651',
  //   storageBucket: 'sarfapp-62651.appspot.com',
  // );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDElDCUAwVQH60SwwyCpQowaiOKJkOytqE",
    appId: '1:651573448048:android:aa25f85a1d5d5bae1c13b5',
    messagingSenderId: '651573448048',
    projectId: 'sarf-70217',
    storageBucket: 'sarf-70217.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBi_WoeaM0GEupEdryRSmBqXzpPMZhNyHQ',
    appId: '1:970811725126:ios:b3f7345842387ec8e60147',
    messagingSenderId: '970811725126',
    projectId: 'sarfapp-62651',
    storageBucket: 'sarfapp-62651.appspot.com',
    iosClientId: '970811725126-ionhecjaoss2gh4accikq4ol26428su9.apps.googleusercontent.com',
    iosBundleId: 'com.example.sarf',
  );
}
