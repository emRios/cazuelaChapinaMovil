import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/pages/home_screen.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginButtonPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa email y contraseña')),
      );
      return;
    }

    context.read<LoginBloc>().add(LoginRequested(email, password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is LoginSuccess) {
            // Navega a HomeScreen pasando el usuario autenticado
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomeScreen(user: state.user),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const CircularProgressIndicator();
                      }

                      return ElevatedButton(
                        onPressed: _onLoginButtonPressed,
                        child: const Text('Iniciar sesión'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/login_bloc.dart';
// import '../bloc/login_event.dart';
// import '../bloc/login_state.dart';
// import '../../../home/pages/home_screen.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange.shade50,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Card(
//             elevation: 4,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: BlocListener<LoginBloc, LoginState>(
//                 listener: (context, state) {
//                   if (state.user != null) {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => HomeScreen(user: state.user!)),
//                     );
//                   }
//                 },
//                 child: BlocBuilder<LoginBloc, LoginState>(
//                   builder: (context, state) {
//                     return Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           'La Cazuela Chapina',
//                           style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.deepOrange),
//                         ),
//                         const SizedBox(height: 24),
//                         TextField(
//                           decoration: const InputDecoration(
//                               labelText: 'Correo electrónico'),
//                           onChanged: (value) => context
//                               .read<LoginBloc>()
//                               .add(LoginEmailChanged(value)),
//                         ),
//                         const SizedBox(height: 16),
//                         TextField(
//                           decoration:
//                               const InputDecoration(labelText: 'Contraseña'),
//                           obscureText: true,
//                           onChanged: (value) => context
//                               .read<LoginBloc>()
//                               .add(LoginPasswordChanged(value)),
//                         ),
//                         const SizedBox(height: 16),
//                         if (state.error != null)
//                           Text(state.error!,
//                               style: const TextStyle(color: Colors.red)),
//                         ElevatedButton(
//                           onPressed: state.isLoading
//                               ? null
//                               : () => context
//                                   .read<LoginBloc>()
//                                   .add(const LoginSubmitted()),
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.orange),
//                           child: state.isLoading
//                               ? const CircularProgressIndicator(
//                                   color: Colors.white)
//                               : const Text('Ingresar'),
//                         )
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/login_bloc.dart';
// import '../bloc/login_event.dart';
// import '../bloc/login_state.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.orange.shade50,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Card(
//             elevation: 4,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: BlocBuilder<LoginBloc, LoginState>(
//                 builder: (context, state) {
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         'La Cazuela Chapina',
//                         style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.deepOrange),
//                       ),
//                       const SizedBox(height: 24),
//                       TextField(
//                         decoration: const InputDecoration(
//                             labelText: 'Correo electrónico'),
//                         onChanged: (value) => context
//                             .read<LoginBloc>()
//                             .add(LoginEmailChanged(value)),
//                       ),
//                       const SizedBox(height: 16),
//                       TextField(
//                         decoration:
//                             const InputDecoration(labelText: 'Contraseña'),
//                         obscureText: true,
//                         onChanged: (value) => context
//                             .read<LoginBloc>()
//                             .add(LoginPasswordChanged(value)),
//                       ),
//                       const SizedBox(height: 16),
//                       if (state.error != null)
//                         Text(state.error!,
//                             style: const TextStyle(color: Colors.red)),
//                       ElevatedButton(
//                         onPressed: state.isLoading
//                             ? null
//                             : () => context
//                                 .read<LoginBloc>()
//                                 .add(const LoginSubmitted()),
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange),
//                         child: state.isLoading
//                             ? const CircularProgressIndicator(
//                                 color: Colors.white)
//                             : const Text('Ingresar'),
//                       )
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
