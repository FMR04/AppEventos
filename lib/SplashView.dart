import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';

// Presentación breve al abrir la aplicación.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xFFEAE3FF),
              child: Icon(Icons.bolt_rounded, size: 48, color: colorPrincipal),
            ),
            SizedBox(height: 18),
            Text('planazo', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: colorTexto)),
            SizedBox(height: 5),
            Text('Descubre lo que pasa cerca de ti', style: TextStyle(color: Color(0xFF77717F))),
          ],
        ),
      ),
    );
  }
}
