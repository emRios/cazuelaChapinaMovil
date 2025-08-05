import 'package:flutter/material.dart';
import '../../../features/auth/domain/user_entity.dart';
import '../models/menu_option.dart';

class HomeScreen extends StatelessWidget {
  final UserEntity user;

  const HomeScreen({super.key, required this.user});

  static final List<MenuOption> opciones = [
    const MenuOption(
        nombre: 'Inventario',
        icono: Icons.inventory,
        ruta: '/inventario',
        modulo: 'inventario'),
    const MenuOption(
        nombre: 'Dashboard',
        icono: Icons.dashboard,
        ruta: '/dashboard',
        modulo: 'dashboard'),
    const MenuOption(
        nombre: 'Reportes',
        icono: Icons.bar_chart,
        ruta: '/reportes',
        modulo: 'reportes'),
    const MenuOption(
        nombre: 'Combos',
        icono: Icons.fastfood,
        ruta: '/combos',
        modulo: 'combos'),
    const MenuOption(
        nombre: 'Personalizar',
        icono: Icons.build,
        ruta: '/personalizar',
        modulo: 'personalizar'),
    const MenuOption(
        nombre: 'Carrito',
        icono: Icons.shopping_cart,
        ruta: '/carrito',
        modulo: 'carrito'),
    const MenuOption(
        nombre: 'Pedidos',
        icono: Icons.list_alt,
        ruta: '/pedidos',
        modulo: 'pedidos'),
  ];

  @override
  Widget build(BuildContext context) {
    final modulosPermitidos =
        opciones.where((o) => user.modulos.contains(o.modulo)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('La Cazuela Chapina'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: modulosPermitidos.map((option) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, option.ruta, arguments: user);
            },
            child: Card(
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(option.icono, size: 48, color: Colors.orange),
                  const SizedBox(height: 8),
                  Text(option.nombre),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
