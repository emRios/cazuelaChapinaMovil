import '../data/models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel?> login(String email, String password);
  Future<String?> getToken(); // Nuevo método para obtener token
}
