class UserEntity {
  final String email;
  final String rol;
  final List<String> modulos;
  final String token;
  final String password;

  UserEntity({
    required this.email,
    required this.rol,
    required this.modulos,
    required this.token,
    required this.password,
  });
}
