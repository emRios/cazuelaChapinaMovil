import 'package:flutter/material.dart';
import '../../../dashboard/presentation/pages/dashboard_screen.dart';
import '../../../home/pages/home_screen.dart';
import '../../../personalizar/presentacion/pages/personalizar_screen.dart';
import '../../data/repositories/auth_repository.dart';

import '../../domain/user_entity.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  final AuthRepository authRepository;
  const SplashScreen({Key? key, required this.authRepository})
      : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    final token = await widget.authRepository.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      UserEntity user;
      try {
        user = widget.authRepository.getUserFromToken(token);
      } catch (e) {
        // Token inválido
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    LoginScreen(authRepository: widget.authRepository)));
        return;
      }

      // Navegación priorizada
      if (user.modulos.contains('dashboard')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      } else if (user.modulos.contains('personalizar')) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PersonalizarScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen(user: user)),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => LoginScreen(authRepository: widget.authRepository)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import '../../domain/i_auth_repository.dart';

// class SplashScreen extends StatefulWidget {
//   final IAuthRepository authRepository;

//   const SplashScreen({Key? key, required this.authRepository})
//       : super(key: key);

//   @override
//   SplashScreenState createState() => SplashScreenState();
// }

// class SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();

//     SchedulerBinding.instance.addPostFrameCallback((_) async {
//       await _checkLogin();
//     });
//   }

//   Future<void> _checkLogin() async {
//     final token = await widget.authRepository.getToken();

//     if (!mounted) return;

//     if (token != null && token.isNotEmpty) {
//       Navigator.pushReplacementNamed(context, '/dashboard');
//     } else {
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
