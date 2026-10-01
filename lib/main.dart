import 'package:flutter/material.dart';
import 'SplashView.dart';
import 'onboarding_view.dart';
import 'home_view.dart';

void main() {
  runApp(const AppEventos());
}

// Colores compartidos por las pantallas principales.
const Color colorFondo = Color(0xFFF8F7F4);
const Color colorPrincipal = Color(0xFF6338D6);
const Color colorTexto = Color(0xFF201C2B);

class AppEventos extends StatelessWidget {
  const AppEventos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planazo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: colorFondo,
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorPrincipal,
          surface: colorFondo,
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashView(),
        '/onboarding': (context) => const OnboardingView(),
        '/home': (context) => const HomeView(),
      },
    );
  }
}
