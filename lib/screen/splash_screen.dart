import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const Color green = Color(0xFF2E7D5A);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scale = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    // mulai animasi “nge-pop” dari kecil → besar
    _controller.forward();

    // setelah 1.4 detik pindah ke login
    Future.delayed(const Duration(milliseconds: 1400), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // logo di-scale pakai animasi controller
        child: ScaleTransition(
          scale: _scale,
          child: const Hero(
            tag: 'logo_cuppy',
            child: _SplashLogo(),
          ),
        ),
      ),
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 60,
        backgroundColor: SplashScreen.green,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Image(
            image: AssetImage('assets/img/icon.png'),
            width: 90,
            height: 90,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}