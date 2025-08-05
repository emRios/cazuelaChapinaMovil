import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

// IMPORTA TUS REPOS Y SCREENS
import 'core/constants.dart';
import 'core/services/preferences_service.dart';
import 'features/auth/presentation/bloc/login_bloc.dart';
import 'features/auth/presentation/pages/SplashScreen.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/dashboard/data/repositories/dashboard_repository.dart';
import 'features/personalizar/data/repositories/personalizar_repository.dart';
import 'features/dashboard/presentation/pages/dashboard_screen.dart';
import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'features/home/pages/home_screen.dart';
import 'features/auth/data/repositories/auth_repository.dart'; // ejemplo
import 'features/auth/domain/user_entity.dart';
import 'features/personalizar/pages/personalizar_screen.dart';
import 'features/personalizar/presentacion/bloc/personalizar_bloc.dart';

void main() async {
  final dio = Dio();
  final baseUrl = getBaseUrl();
  WidgetsFlutterBinding.ensureInitialized();

  final prefsInstance = await SharedPreferences.getInstance();
  final prefsService = PreferencesService(prefsInstance);

  final authRepository = AuthRepository(prefsService);

  final dashboardRepository = DashboardRepository(
    dio: dio,
    baseUrl: baseUrl,
  );

  final personalizarRepository = PersonalizarRepository(
    dio: dio,
    baseUrl: baseUrl,
    token: '',
  );

  runApp(MyApp(
    dashboardRepository: dashboardRepository,
    personalizarRepository: personalizarRepository,
    authRepository: authRepository,
  ));
}

class MyApp extends StatelessWidget {
  final DashboardRepository dashboardRepository;
  final PersonalizarRepository personalizarRepository;
  final AuthRepository authRepository;

  const MyApp({
    Key? key,
    required this.dashboardRepository,
    required this.personalizarRepository,
    required this.authRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Cazuela Chapina',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(authRepository: authRepository),
        '/login': (context) => BlocProvider(
              create: (_) => LoginBloc(authRepository: authRepository),
              child: LoginScreen(authRepository: authRepository),
            ),
        '/dashboard': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
          return BlocProvider(
            create: (_) => DashboardBloc(dashboardRepository, user),
            child: DashboardScreen(),
          );
        },
        '/personalizar': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
          return BlocProvider(
            create: (_) => PersonalizarBloc(
              user: user,
              repository: personalizarRepository,
            ),
            child: const PersonalizarScreen(),
          );
        },
        '/home': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
          return HomeScreen(user: user);
        },
        // ...agrega aquí más rutas para otros módulos
      },
      // Si quieres manejar rutas dinámicas, puedes usar onGenerateRoute
      // onGenerateRoute: (settings) {...},
      // theme: ... // agrega tu tema si tienes uno definido
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'core/services/preferences_service.dart';
// import 'features/auth/data/repositories/auth_repository.dart';
// import 'features/auth/domain/i_auth_repository.dart';
// import 'features/auth/presentation/bloc/login_bloc.dart';
// import 'features/auth/presentation/pages/SplashScreen.dart';
// import 'features/auth/presentation/pages/login_screen.dart';
// import 'features/dashboard/data/repositories/dashboard_repository.dart';
// import 'features/dashboard/presentation/bloc/dashboard_bloc.dart';
// import 'features/dashboard/presentation/pages/dashboard_screen.dart';
// import 'features/auth/domain/user_entity.dart';
// import 'features/home/pages/home_screen.dart';
// import 'core/constants.dart';
// import 'features/personalizar/presentacion/bloc/personalizar_bloc.dart';

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
  
//   get personalizarRepository => null;

//   @override
//   Widget build(BuildContext context) {
//     // Instancia Dio con base URL
//     final dio = Dio(
//       BaseOptions(baseUrl: getBaseUrl()),
//     );

//     // Instancia repositorio dashboard con dio
//     final dashboardRepository = DashboardRepository(dio);

//     return MaterialApp(
//       title: 'La Cazuela Chapina',
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => SplashScreen(authRepository: authRepository),

//         '/login': (context) => BlocProvider(
//               create: (_) => LoginBloc(authRepository: authRepository),
//               child: LoginScreen(authRepository: authRepository),
//             ),

//         '/home': (context) {
//           final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
//           return HomeScreen(user: user);
//         },

//         '/personalizar': (context) {
//       // Si necesitas argumentos (ej: UserEntity):
//       // final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
//       return BlocProvider(
//         create: (_) => PersonalizarBloc(repository: personalizarRepository),
//         child: const PersonalizarScreen(),
//       );
//     },

//         '/dashboard': (context) {
//           final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
//           return BlocProvider(
//             create: (_) => DashboardBloc(dashboardRepository, user: user),
//             child: const DashboardScreen(),
//           );
//         },

//         // Otras rutas según módulos que tengas
//       },
//     );
//   }
// }



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

//   // @override
//   // Widget build(BuildContext context) {
//   //   return MaterialApp(
//   //     title: 'La Cazuela Chapina',
//   //     debugShowCheckedModeBanner: false,
//   //     initialRoute: '/',
//   //     routes: {
//   //       '/': (context) => SplashScreen(authRepository: authRepository),
//   //       '/login': (context) => BlocProvider(
//   //             create: (_) => LoginBloc(authRepository: authRepository),
//   //             child: const LoginScreen(authRepository: authRepository),
//   //           ),
//   //       '/dashboard': (context) => const DashboardScreen(),
//   //     },
//   //   );
//   // }
// }

