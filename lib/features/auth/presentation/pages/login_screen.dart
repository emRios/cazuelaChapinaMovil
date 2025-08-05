import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/i_auth_repository.dart';
import '../bloc/login_bloc.dart';
import '../../../home/pages/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final IAuthRepository authRepository;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key, required this.authRepository}) : super(key: key);

  void _onLoginButtonPressed(BuildContext context) {
    final email = _emailController.text;
    final password = _passwordController.text;

    context.read<LoginBloc>().add(
          LoginRequested(email: email, password: password),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(authRepository: authRepository),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is LoginSuccess) {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordController,
                      decoration:
                          const InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const CircularProgressIndicator();
                        }
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _onLoginButtonPressed(context),
                            child: const Text('Iniciar sesión'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:cazuela_movil/features/auth/domain/i_auth_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../home/pages/home_screen.dart';
// import '../../data/repositories/auth_repository.dart';
// import '../bloc/login_bloc.dart';

// class LoginScreen extends StatelessWidget  {
//   final IAuthRepository authRepository;
//   // Controladores para los campos de texto
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   LoginScreen({Key? key, required this.authRepository}) : super(key: key);

//   void _onLoginButtonPressed(BuildContext context) {
//     final email = _emailController.text;
//     final password = _passwordController.text;

//     context.read<LoginBloc>().add(
//       LoginRequested(email: email, password: password),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<LoginBloc>(
//       create: (_) => LoginBloc(authRepository: authRepository),
//       child: Scaffold(
//         body: BlocListener<LoginBloc, LoginState>(
//           listener: (context, state) {
//             if (state is LoginFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.error)),
//               );
//             } else if (state is LoginSuccess) {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => HomeScreen(user: state.user),
//                 ),
//               );
//             }
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     TextField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(labelText: 'Email'),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 12),
//                     TextField(
//                       controller: _passwordController,
//                       decoration: const InputDecoration(labelText: 'Contraseña'),
//                       obscureText: true,
//                     ),
//                     const SizedBox(height: 20),
//                     BlocBuilder<LoginBloc, LoginState>(
//                       builder: (context, state) {
//                         if (state is LoginLoading) {
//                           return const CircularProgressIndicator();
//                         }
//                         return ElevatedButton(
//                           onPressed: () => _onLoginButtonPressed(context),
//                           child: const Text('Iniciar sesión'),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }



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
