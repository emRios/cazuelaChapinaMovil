// features/personalizar/data/models/tamal_model.dart

class TamalOpcionesModel {
  final List<String> masas;
  final List<String> rellenos;
  final List<String> envolturas;
  final List<String> nivelesPicante;

  TamalOpcionesModel({
    required this.masas,
    required this.rellenos,
    required this.envolturas,
    required this.nivelesPicante,
  });

  factory TamalOpcionesModel.fromJson(Map<String, dynamic> json) {
    return TamalOpcionesModel(
      masas: List<String>.from(json['masas'] ?? []),
      rellenos: List<String>.from(json['rellenos'] ?? []),
      envolturas: List<String>.from(json['envolturas'] ?? []),
      nivelesPicante: List<String>.from(json['picantes'] ?? []),
    );
  }
}
