import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/screens/home_page.dart';
import 'package:social_app/screens/profile_page.dart';
import 'package:social_app/services/auth/auth_pages_flow.dart';
import 'package:social_app/theme/dark_mode.dart';
import 'package:social_app/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPagesFlow(),
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: ThemeMode.system,

      routes: {
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
