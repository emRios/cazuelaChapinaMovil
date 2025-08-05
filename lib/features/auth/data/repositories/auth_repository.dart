import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants.dart';
import '../../../../core/services/preferences_service.dart';
import '../../domain/i_auth_repository.dart';
import '../../domain/user_entity.dart';
import '../models/user_model.dart';

class AuthRepository implements IAuthRepository {
  final PreferencesService prefsService;
  final Dio dio;

  AuthRepository(this.prefsService) : dio = Dio();

  @override
  Future<UserModel?> login(String email, String password) async {
    try {
      final url = '${getBaseUrl()}/login';

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

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  @override
  UserEntity getUserFromToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) throw Exception('Token inválido');
    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final data = jsonDecode(payload);

    return UserEntity(
      id: data['sub'] ?? '',
      nombre: data['nombre'] ?? '',
      modulos: List<String>.from(data['modulos'] ?? []),
      token: token,
      email: '',
      password: '',
      rol: '',
    );
  }
}
