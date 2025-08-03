import 'package:dio/dio.dart';
import '../models/dashboard_metricas_model.dart';

class DashboardRepository {
  final Dio dio;

  DashboardRepository(this.dio);

  Future<DashboardMetricasModel> obtenerMetricas() async {
    final response = await dio.get('/dashboard/metricas');

    return DashboardMetricasModel.fromJson(response.data);
  }
}
