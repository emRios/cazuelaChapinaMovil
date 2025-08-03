import '../../domain/entities/dashboard_metricas_entity.dart';

class DashboardMetricasModel extends DashboardMetricasEntity {
  DashboardMetricasModel({
    required super.totalVentas,
    required super.totalPedidos,
    required super.ingresos,
  });

  factory DashboardMetricasModel.fromJson(Map<String, dynamic> json) {
    return DashboardMetricasModel(
      totalVentas: json['totalVentas'],
      totalPedidos: json['totalPedidos'],
      ingresos: (json['ingresos'] as num).toDouble(),
    );
  }
}
