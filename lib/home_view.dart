import 'package:flutter/material.dart';
import 'main.dart';

// Ejemplos para dar una base visual a la página principal.
class Evento {
  const Evento({required this.nombre, required this.tipo, required this.fecha, required this.lugar, required this.icono, required this.color, required this.precio});

  final String nombre;
  final String tipo;
  final String fecha;
  final String lugar;
  final String precio;
  final IconData icono;
  final Color color;
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _categoriaActual = 0;
  final List<String> _categorias = ['Para ti', 'Música', 'Cultura', 'Gastronomía'];
  final List<Evento> _eventos = const [
    Evento(nombre: 'Noche de conciertos', tipo: 'MÚSICA EN DIRECTO', fecha: 'Sáb, 18 oct · 20:00', lugar: 'La Riviera · Madrid', precio: 'Desde 18 €', icono: Icons.music_note_rounded, color: Color(0xFFE8DFFF)),
    Evento(nombre: 'Mercado de diseño', tipo: 'ARTE Y DISEÑO', fecha: 'Dom, 19 oct · 11:00', lugar: 'Matadero Madrid', precio: 'Gratis', icono: Icons.brush_rounded, color: Color(0xFFFFE5C7)),
    Evento(nombre: 'Sabores del mundo', tipo: 'GASTRONOMÍA', fecha: 'Vie, 24 oct · 13:00', lugar: 'Plaza de España', precio: 'Desde 5 €', icono: Icons.restaurant_rounded, color: Color(0xFFD7F0E6)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Cabecera con ubicación y accesos rápidos.
                      Row(
                        children: [
                          const Icon(Icons.bolt_rounded, color: colorPrincipal, size: 29),
                          const SizedBox(width: 5),
                          const Text('planazo', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: colorTexto)),
                          const Spacer(),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded), tooltip: 'Buscar'),
                          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border_rounded), tooltip: 'Guardados'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: colorPrincipal, size: 19),
                          const SizedBox(width: 5),
                          Text('Madrid, España', style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600)),
                          const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Text('¿Qué plan te apetece?', style: TextStyle(fontSize: 30, height: 1.1, fontWeight: FontWeight.w800, color: colorTexto)),
                      const SizedBox(height: 8),
                      const Text('Ideas para disfrutar la ciudad, hoy y cualquier día.', style: TextStyle(fontSize: 14, color: Color(0xFF77717F))),
                      const SizedBox(height: 22),
                      // Selector sencillo de categorías.
                      SizedBox(
                        height: 42,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categorias.length,
                          itemBuilder: (context, indice) {
                            final bool seleccionada = indice == _categoriaActual;
                            return Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: ChoiceChip(
                                label: Text(_categorias[indice]),
                                selected: seleccionada,
                                onSelected: (valor) => setState(() => _categoriaActual = indice),
                                selectedColor: colorPrincipal,
                                labelStyle: TextStyle(color: seleccionada ? Colors.white : colorTexto, fontWeight: FontWeight.w600),
                                side: BorderSide.none,
                                showCheckmark: false,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 27),
                      Row(
                        children: [
                          const Expanded(child: Text('Cerca de ti', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: colorTexto))),
                          TextButton(onPressed: () {}, child: const Text('Ver todos')),
                        ],
                      ),
                    ]),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList.builder(
                    itemCount: _eventos.length,
                    itemBuilder: (context, indice) => _tarjetaEvento(_eventos[indice]),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        ),
      ),
      // Navegación inferior preparada para ampliar la aplicación.
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explorar'),
          NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'Guardados'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  // Tarjeta con información breve y una ilustración con icono.
  Widget _tarjetaEvento(Evento evento) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 92,
              height: 104,
              decoration: BoxDecoration(color: evento.color, borderRadius: BorderRadius.circular(15)),
              child: Icon(evento.icono, size: 38, color: colorTexto),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(evento.tipo, style: const TextStyle(fontSize: 10, letterSpacing: 1.1, fontWeight: FontWeight.w800, color: colorPrincipal)),
                  const SizedBox(height: 5),
                  Text(evento.nombre, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: colorTexto)),
                  const SizedBox(height: 7),
                  Text(evento.fecha, style: const TextStyle(fontSize: 12, color: Color(0xFF77717F))),
                  const SizedBox(height: 3),
                  Text(evento.lugar, style: const TextStyle(fontSize: 12, color: Color(0xFF77717F))),
                  const SizedBox(height: 8),
                  Text(evento.precio, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: colorTexto)),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border_rounded), tooltip: 'Guardar evento'),
          ],
        ),
      ),
    );
  }
}
