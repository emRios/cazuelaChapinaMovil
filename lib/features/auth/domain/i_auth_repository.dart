import 'package:cazuela_movil/features/auth/domain/user_entity.dart';

import '../data/models/user_model.dart';

abstract class IAuthRepository {
  Future<String?> getToken();
  Future<void> saveToken(String token);
  Future<void> clearToken();
  UserEntity getUserFromToken(String token);
  Future<UserModel?> login(String email, String password);
}
