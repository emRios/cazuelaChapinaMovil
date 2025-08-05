// features/personalizar/data/models/bebida_model.dart

class BebidaOpcionesModel {
  final List<String> tamanios;
  final List<String> tipos;
  final List<String> endulzantes;
  final List<String> toppings;

  BebidaOpcionesModel({
    required this.tamanios,
    required this.tipos,
    required this.endulzantes,
    required this.toppings,
  });

  factory BebidaOpcionesModel.fromJson(Map<String, dynamic> json) {
    return BebidaOpcionesModel(
      tamanios: List<String>.from(json['tamanios'] ?? []),
      tipos: List<String>.from(json['tipos'] ?? []),
      endulzantes: List<String>.from(json['endulzantes'] ?? []),
      toppings: List<String>.from(json['toppings'] ?? []),
    );
  }
}
