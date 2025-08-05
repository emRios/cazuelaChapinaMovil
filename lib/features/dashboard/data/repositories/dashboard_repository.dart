import 'package:dio/dio.dart';
import '../models/dashboard_metricas_model.dart';

import 'package:dio/dio.dart';
// Importa tus modelos aquí
// import '../models/dashboard_metricas_model.dart';

class DashboardRepository {
  final Dio dio;
  final String baseUrl;

  DashboardRepository({
    required this.dio,
    required this.baseUrl,
  });

  Future<DashboardMetricasModel> obtenerMetricas(
      {required String token}) async {
    final response = await dio.get(
      '$baseUrl/dashboard/metricas',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return DashboardMetricasModel.fromJson(response.data);
  }
}




// class DashboardRepository {
//   final Dio dio;

//   DashboardRepository(this.dio);

//   Future<DashboardMetricasModel> obtenerMetricas() async {
//     final response = await dio.get('/dashboard/metricas');

//     return DashboardMetricasModel.fromJson(response.data);
//   }
// }
