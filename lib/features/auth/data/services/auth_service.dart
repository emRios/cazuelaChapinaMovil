import '../../../../core/services/preferences_service.dart';

class AuthService {
  final PreferencesService prefsService;

  AuthService(this.prefsService);

  Future<void> login(String token, String password) async {
    // Guarda el token usando PreferencesService
    await prefsService.setString('token', token);
  }

  String? getToken() {
    return prefsService.getString('token');
  }

  Future<void> logout() async {
    await prefsService.remove('token');
  }
}




// import 'package:dio/dio.dart';
// import '../../../../core/constants.dart';
// import '../../../../core/services/preferences_service.dart';
// import '../models/user_model.dart';

// const login = 'login';

// class AuthService {
//   final Dio dio;
//   final PreferencesService prefs;

//   AuthService({required this.dio, required this.prefs});

//   Future<UserModel?> login(String email, String password) async {
//     try {
//       // ignore: avoid_print
//       print('[DEBUG] Login → POST ${getBaseUrl()}login');
//       // ignore: avoid_print
//       print('[DEBUG] Body: {"email": "$email", "password": "$password"}');

//       final response = await dio.post(
//         '${getBaseUrl()}$login',
//         data: {
//           'email': email,
//           'password': password,
//         },
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//         }),
//       );

//       // ignore: avoid_print
//       print('[DEBUG] Status Code: ${response.statusCode}');
//       // ignore: avoid_print
//       print('[DEBUG] Response Data: ${response.data}');

//       if (response.statusCode == 200) {
//         final user = UserModel.fromJson({
//           ...response.data,
//           'password': password,
//         });

//         await prefs.setToken(user.token);
//         return user;
//       }
//     } catch (err) {
//       // ignore: avoid_print
//       print('AuthService login error: $err');
//     }

//     return null;
//   }
// }
