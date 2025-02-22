import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyAYVK96_JIv2JF1U2APAMJGmK0DpeNqGlc',
      appId: '1:195580050111:web:9f273c86aa17286f0ba40a',
      messagingSenderId: '195580050111',
      projectId: 'deped-reading-app',
      authDomain: 'deped-reading-app.firebaseapp.com',
      storageBucket: 'deped-reading-app.firebasestorage.app',
    );
  }
}