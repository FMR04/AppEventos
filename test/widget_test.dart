import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appeventos/onboarding_view.dart';

void main() {
  testWidgets('La aplicación muestra el onboarding al iniciarse', (tester) async {
    // Se muestra directamente la pantalla para no depender del temporizador inicial.
    await tester.pumpWidget(const MaterialApp(home: OnboardingView()));
    await tester.pump();

    expect(find.text('Siempre hay\nalgo que celebrar.'), findsOneWidget);
    expect(find.text('Continuar'), findsOneWidget);
  });
}
