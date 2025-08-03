import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../domain/i_auth_repository.dart';

class SplashScreen extends StatefulWidget {
  final IAuthRepository authRepository;

  const SplashScreen({Key? key, required this.authRepository})
      : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    final token = await widget.authRepository.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
