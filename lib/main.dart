import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/preferences_service.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/domain/i_auth_repository.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/auth/presentation/pages/SplashScreen.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/dashboard/data/repositories/dashboard_repository.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/dashboard/presentation/pages/dashboard_screen.dart';
import 'features/auth/domain/user_entity.dart';
import 'features/home/pages/home_screen.dart';
import 'core/constants.dart'; // Para getBaseUrl()

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefsInstance = await SharedPreferences.getInstance();
  final prefsService = PreferencesService(prefsInstance);

  final authRepository = AuthRepository(prefsService);

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final IAuthRepository authRepository;

  const MyApp({Key? key, required this.authRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Instancia Dio con base URL
    final dio = Dio(
      BaseOptions(baseUrl: getBaseUrl()),
    );

    // Instancia repositorio dashboard con dio
    final dashboardRepository = DashboardRepository(dio);

    return MaterialApp(
      title: 'La Cazuela Chapina',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(authRepository: authRepository),

        '/login': (context) => BlocProvider(
              create: (_) => LoginBloc(authRepository: authRepository),
              child: const LoginScreen(),
            ),

        '/home': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
          return HomeScreen(user: user);
        },

        '/dashboard': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
          return BlocProvider(
            create: (_) => DashboardBloc(dashboardRepository, user: user),
            child: const DashboardScreen(),
          );
        },

        // Otras rutas según módulos que tengas
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'core/services/preferences_service.dart';
// import 'features/auth/data/repositories/auth_repository.dart';
// import 'features/auth/presentation/bloc/login_bloc.dart';
// import 'features/auth/presentation/pages/SplashScreen.dart';
// import 'features/auth/presentation/pages/login_screen.dart';
// import 'features/dashboard/presentation/pages/dashboard_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   final prefsInstance = await SharedPreferences.getInstance();
//   final prefsService = PreferencesService(prefsInstance);

//   final authRepository = AuthRepository(prefsService);

//   runApp(MyApp(authRepository: authRepository));
// }

// class MyApp extends StatelessWidget {
//   final AuthRepository authRepository;

//   const MyApp({Key? key, required this.authRepository}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'La Cazuela Chapina',
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => SplashScreen(authRepository: authRepository),
//         '/login': (context) => BlocProvider(
//               create: (_) => LoginBloc(authRepository: authRepository),
//               child: const LoginScreen(),
//             ),
//         '/dashboard': (context) => const DashboardScreen(),
//       },
//     );
//   }
// }

