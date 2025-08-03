import 'package:dio/dio.dart';

import '../../../../core/constants.dart';
import '../../../../core/services/preferences_service.dart';
import '../../domain/i_auth_repository.dart';
import '../models/user_model.dart';

class AuthRepository implements IAuthRepository {
  final PreferencesService prefsService;
  final Dio dio;

  AuthRepository(this.prefsService) : dio = Dio();

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final url = '${getBaseUrl()}login';

      final response = await dio.post(
        url,
        data: {'email': email, 'password': password},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final userJson = Map<String, dynamic>.from(response.data);
        userJson['password'] = password;

        final user = UserModel.fromJson(userJson);

        await prefsService.setString('token', user.token);
        await prefsService.setString('email', user.email);
        await prefsService.setString('rol', user.rol);
        await prefsService.setString('modulos', user.modulos.join(','));

        return user;
      } else {
        // ignore: avoid_print
        print('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Login error: $e');
    }

    return null;
  }

  @override
  Future<String?> getToken() async {
    return prefsService.getString('token');
  }
}


// import '/core/services/preferences_service.dart'; // Ajusta la ruta
// import '../../domain/i_auth_repository.dart';
// import '../models/user_model.dart';

// class AuthRepository implements IAuthRepository {
//   final PreferencesService prefsService;

//   AuthRepository(this.prefsService);

//   @override
//   Future<UserModel?> login(String email, String password) async {
//     // Simulación de llamada al backend
//     await Future.delayed(const Duration(seconds: 1));

//     if (email == 'test@correo.com' && password == '1234') {
//       final userData = {
//         'email': email,
//         'rol': 'admin',
//         'modulos': ['dashboard', 'inventario'],
//         'token': 'abc123token',
//         'password': password,
//       };

//       final user = UserModel.fromJson(userData);

//       await prefsService.setString('token', user.token);
//       await prefsService.setString('email', user.email);
//       await prefsService.setString('rol', user.rol);
//       await prefsService.setString('modulos', user.modulos.join(','));

//       return user;
//     } else {
//       return null;
//     }
//   }

//   @override
//   Future<String?> getToken() async {
//     return prefsService.getString('token');
//   }
// }



// import '../models/user_model.dart';
// import 'package:dio/dio.dart';

// abstract class IAuthRepository {
//   Future<UserModel> login(String email, String password);
// }

// class AuthRepository implements IAuthRepository {
//   final Dio dio;

//   AuthRepository(this.dio);

//   @override
//   Future<UserModel> login(String email, String password) async {
//     final response = await dio.post('http://localhost:9000/login', data: {
//       'email': email,
//       'password': password,
//     });

//     if (response.statusCode == 200) {
//       return UserModel.fromJson({
//         ...response.data,
//         'password': password, // añadimos localmente
//       });
//     } else {
//       throw Exception('Login failed');
//     }
//   }
// }
