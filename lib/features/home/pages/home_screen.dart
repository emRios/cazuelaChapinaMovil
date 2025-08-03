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


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../auth/domain/user_entity.dart';
// import 'package:dio/dio.dart';
// import '../../dashboard/data/repositories/dashboard_repository.dart';
// import '../../dashboard/presentation/bloc/dashboard_bloc.dart';
// import '../../dashboard/presentation/pages/dashboard_screen.dart';

// class HomeScreen extends StatelessWidget {
//   final UserEntity user;

//   const HomeScreen({Key? key, required this.user}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final modulosDisponibles = _modulos.where((modulo) {
//       final nombre = modulo['nombre'] as String;
//       return user.modulos.contains(nombre);
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('La Cazuela Chapina'),
//       ),
//       body: GridView.count(
//         padding: const EdgeInsets.all(16.0),
//         crossAxisCount: 2,
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         children: modulosDisponibles.map((modulo) {
//           final String titulo = modulo['titulo'] as String;
//           final IconData icono = modulo['icono'] as IconData;
//           final Widget Function(BuildContext, UserEntity) ruta =
//               modulo['ruta'] as Widget Function(BuildContext, UserEntity);

//           return Card(
//             elevation: 4,
//             child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => ruta(context, user),
//                   ),
//                 );
//               },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(icono, size: 40),
//                   const SizedBox(height: 8),
//                   Text(titulo),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// final List<Map<String, dynamic>> _modulos = [
//   {
//     'nombre': 'dashboard',
//     'titulo': 'Dashboard',
//     'icono': Iconsax.graph,
//     // 'ruta': (BuildContext context, UserEntity user) => const DashboardScreen(),
//     'ruta': (BuildContext context, UserEntity user) => BlocProvider(
//           create: (_) => DashboardBloc(DashboardRepository(DashboardRepository)),
//           child: const DashboardScreen(),
//         ),
//   },
//   // Puedes añadir otros módulos con la misma estructura
// ];




// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../auth/domain/user_entity.dart';

// class HomeScreen extends StatelessWidget {
//   final UserEntity user;

//   const HomeScreen({Key? key, required this.user}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> opciones = [
//       {
//         'modulo': 'combos',
//         'icono': Iconsax.coffee,
//         'label': 'Combos',
//         'onTap': () {
//           // TODO: Navegar a combos
//         }
//       },
//       {
//         'modulo': 'personalizar',
//         'icono': Iconsax.setting_2,
//         'label': 'Personalizar',
//         'onTap': () {
//           // TODO: Navegar a personalizar
//         }
//       },
//       {
//         'modulo': 'carrito',
//         'icono': Iconsax.shopping_cart,
//         'label': 'Carrito',
//         'onTap': () {
//           // TODO: Navegar a carrito
//         }
//       },
//     ];

//     final List<Map<String, dynamic>> modulosPermitidos =
//         opciones.where((op) => user.modulos.contains(op['modulo'])).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('La Cazuela Chapina'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.exit_to_app),
//             onPressed: () {
//               // TODO: logout
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 20,
//           mainAxisSpacing: 20,
//           children: modulosPermitidos.map((op) {
//             return GestureDetector(
//               onTap: op['onTap'],
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.orange.shade100,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.orange.withOpacity(0.2),
//                       blurRadius: 8,
//                       offset: const Offset(2, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(op['icono'], size: 48, color: Colors.deepOrange),
//                     const SizedBox(height: 12),
//                     Text(op['label'], style: const TextStyle(fontSize: 16)),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

