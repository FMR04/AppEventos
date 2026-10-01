import 'package:flutter/material.dart';
import 'main.dart';

// Cada página explica una ventaja de la aplicación.
class OnboardingPage {
  const OnboardingPage({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
    required this.tag,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String description;
  final String tag;
}

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controlador = PageController();
  int _paginaActual = 0;

  final List<OnboardingPage> _paginas = const [
    OnboardingPage(
      icon: Icons.celebration_rounded,
      color: Color(0xFFFFC857),
      tag: 'TU CIUDAD, LLENA DE PLANES',
      title: 'Siempre hay\nalgo que celebrar.',
      description: 'Encuentra conciertos, mercados y experiencias cerca de ti.',
    ),
    OnboardingPage(
      icon: Icons.explore_rounded,
      color: Color(0xFFB6E3D4),
      tag: 'A TU MANERA',
      title: 'Planes que\nvan contigo.',
      description: 'Explora propuestas para cada momento, presupuesto y compañía.',
    ),
    OnboardingPage(
      icon: Icons.favorite_rounded,
      color: Color(0xFFF5B6C8),
      tag: 'BUENOS MOMENTOS',
      title: 'Tu próximo\nrecuerdo empieza aquí.',
      description: 'Guarda tus favoritos y comparte el plan con quien quieras.',
    ),
  ];

  void _continuar() {
    if (_paginaActual < _paginas.length - 1) {
      _controlador.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool ultimaPagina = _paginaActual == _paginas.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Center(
          // El ancho máximo permite que la pantalla también se vea bien en web.
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bolt_rounded, color: colorPrincipal, size: 28),
                      const SizedBox(width: 6),
                      const Text('planazo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: colorTexto)),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                        child: const Text('Saltar'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _controlador,
                      itemCount: _paginas.length,
                      onPageChanged: (indice) => setState(() => _paginaActual = indice),
                      itemBuilder: (context, indice) => _contenidoPagina(_paginas[indice]),
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: List.generate(_paginas.length, (indice) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 7),
                            width: indice == _paginaActual ? 24 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: indice == _paginaActual ? colorPrincipal : const Color(0xFFD9D5E1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        }),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: _continuar,
                        style: FilledButton.styleFrom(
                          backgroundColor: colorPrincipal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [Text(ultimaPagina ? 'Empezar' : 'Continuar'), const SizedBox(width: 8), const Icon(Icons.arrow_forward_rounded, size: 18)],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Ilustración simple hecha con iconos para no depender de imágenes externas.
  Widget _contenidoPagina(OnboardingPage pagina) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tamano = constraints.maxHeight < 500 ? 210 : 290;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: tamano,
              height: tamano,
              decoration: BoxDecoration(color: pagina.color, borderRadius: BorderRadius.circular(tamano * 0.35)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(top: 30, right: 35, child: Icon(Icons.auto_awesome, size: 35, color: Colors.white.withValues(alpha: 0.9))),
                  Positioned(bottom: 32, left: 30, child: Icon(Icons.star_rounded, size: 30, color: Colors.white.withValues(alpha: 0.9))),
                  Icon(pagina.icon, size: tamano * 0.48, color: colorTexto),
                ],
              ),
            ),
            const SizedBox(height: 34),
            Text(pagina.tag, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, letterSpacing: 1.7, fontWeight: FontWeight.w800, color: colorPrincipal)),
            const SizedBox(height: 12),
            Text(pagina.title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 34, height: 1.12, fontWeight: FontWeight.w800, color: colorTexto)),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 390),
              child: Text(pagina.description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, height: 1.5, color: Color(0xFF77717F))),
            ),
          ],
        );
      },
    );
  }
}
