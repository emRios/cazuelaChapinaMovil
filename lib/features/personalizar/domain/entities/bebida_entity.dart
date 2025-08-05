// features/personalizar/domain/entities/bebida_entity.dart

class BebidaEntity {
  final String tamanio;
  final String tipo;
  final String endulzante;
  final String topping;
  final int cantidad;

  BebidaEntity({
    required this.tamanio,
    required this.tipo,
    required this.endulzante,
    required this.topping,
    required this.cantidad,
  });
}
