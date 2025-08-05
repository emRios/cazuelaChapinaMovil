// features/personalizar/data/repositories/personalizar_repository.dart

import 'package:dio/dio.dart';
import '../models/bebida_model.dart';
import '../models/tamal_mode.dart';

class PersonalizarRepository {
  final Dio dio;
  final String baseUrl;
  final String token;

  PersonalizarRepository({
    required this.dio,
    required this.baseUrl,
    required this.token,
  });
  //print('[DEBUG] Login → POST ${getBaseUrl()}login');
  Future<TamalOpcionesModel> obtenerOpcionesTamal(
      {required String token}) async {
    // ignore: avoid_print
    print('TOKEN: $token');
    final response = await dio.get(
      '$baseUrl/personalizar/opciones',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    // ignore: avoid_print
    print('TAMALES: ${response.data}');
    return TamalOpcionesModel.fromJson(response.data['tamales']);
  }

  Future<BebidaOpcionesModel> obtenerOpcionesBebida(
      {required String token}) async {
    final response = await dio.get(
      '$baseUrl/personalizar/opciones',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
    return BebidaOpcionesModel.fromJson(response.data['bebidas']);
  }
}
