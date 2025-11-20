import 'package:flutter/material.dart';
import 'screen/login_screen.dart';
import 'screen/register_screen.dart';
import 'screen/splash_screen.dart'; // <-- IMPORT SPLASH

void main() => runApp(const CuppyApp());

class CuppyApp extends StatelessWidget {
  const CuppyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF2E7D5A);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cuppy Auth',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: green, primary: green),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: green,
          ),
        ),
      ),

      // ⬇️ LAYAR PERTAMA: SPLASH
      routes: {
        '/': (_) => const SplashScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
      },
    );
  }
}

// Kalau mau test backend pakai TestAPI lagi, tinggal pakai main() versi lama
// dan comment kode di atas.