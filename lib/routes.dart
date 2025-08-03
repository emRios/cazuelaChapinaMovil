import 'package:flutter/material.dart';
import 'features/auth/domain/user_entity.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/home/pages/home_screen.dart';

Map<String, WidgetBuilder> appRoutes(UserEntity user) => {
      '/login': (context) => const LoginScreen(),
      '/home': (context) => HomeScreen(user: user),
      // agrega más rutas reales conforme crees pantallas
      '/inventario': (context) => const Placeholder(),
      '/dashboard': (context) => const Placeholder(),
      '/reportes': (context) => const Placeholder(),
      '/combos': (context) => const Placeholder(),
      '/personalizar': (context) => const Placeholder(),
      '/carrito': (context) => const Placeholder(),
      '/pedidos': (context) => const Placeholder(),
    };
