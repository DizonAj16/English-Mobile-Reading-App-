import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart'; 
import 'core/services/auth_service.dart';
import 'core/services/theme_service.dart';
import 'core/services/firestore_service.dart';
import 'config/theme.dart';
import 'features/home/home_page.dart';
import 'features/onboarding/get_started_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.android) {
    // Android auto-initializes, no need for options
    await Firebase.initializeApp();
  } else {
    // Manually initialize Firebase on other platforms
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ThemeService()),
        Provider(create: (_) => FirestoreService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (context, themeService, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Reading App',
          theme: themeService.isDarkMode
              ? AppThemes.darkTheme
              : AppThemes.lightTheme,
          home: FutureBuilder<bool>(
            future: _checkLoginStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                      child: CircularProgressIndicator()), // Wrap with Scaffold
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                  body: Center(child: Text('Error loading app')),
                );
              }
              return snapshot.data == true ? HomePage() : GetStartedPage();
            },
          ),
        );
      },
    );
  }
}