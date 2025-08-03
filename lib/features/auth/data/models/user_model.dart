import '../../domain/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.email,
    required super.rol,
    required super.modulos,
    required super.token,
    required super.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        rol: json['rol'],
        modulos: List<String>.from(json['modulos']),
        token: json['token'],
        password: json['password'] ?? '', // útil en simulaciones
      );
}
