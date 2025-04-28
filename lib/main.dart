import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBvYSlvsgwwJtMe8HzAqAeb_8F3HhNDQJM",
          authDomain: "mockflix-922c0.firebaseapp.com",
          projectId: "mockflix-922c0",
          storageBucket: "mockflix-922c0.firebasestorage.app",
          messagingSenderId: "551777383369",
          appId: "1:551777383369:web:e39da14e2fd87c12846e18"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mockflix',
      theme: new ThemeData(
          scaffoldBackgroundColor: const Color(0xFF290133),
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Color(0xFFe5e7eb)),
            bodyMedium: TextStyle(color: Color(0xFFe5e7eb)),
            bodySmall: TextStyle(color: Color(0xFFe5e7eb)),
            displayLarge: TextStyle(color: Color(0xFFe5e7eb)),
            displayMedium: TextStyle(color: Color(0xFFe5e7eb)),
            displaySmall: TextStyle(color: Color(0xFFe5e7eb)),
            titleLarge: TextStyle(color: Color(0xFFe5e7eb)),
            titleMedium: TextStyle(color: Color(0xFFe5e7eb)),
            titleSmall: TextStyle(color: Color(0xFFe5e7eb)),
            headlineLarge: TextStyle(color: Color(0xFFe5e7eb)),
            headlineMedium: TextStyle(color: Color(0xFFe5e7eb)),
            headlineSmall: TextStyle(color: Color(0xFFe5e7eb)),
            labelLarge: TextStyle(color: Color(0xFFe5e7eb)),
            labelMedium: TextStyle(color: Color(0xFFe5e7eb)),
            labelSmall: TextStyle(color: Color(0xFFe5e7eb)),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF290133),
            iconTheme: IconThemeData(color: Color(0xFFe5e7eb)),
            titleTextStyle: TextStyle(
                color: Color(0xFFe5e7eb),
                fontSize: 22.0,
                fontWeight: FontWeight.normal),
          )),
      home: const LoginScreen(),
    );
  }
}
