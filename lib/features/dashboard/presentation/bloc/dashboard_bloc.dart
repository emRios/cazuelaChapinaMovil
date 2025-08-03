import 'package:cazuela_movil/features/auth/domain/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/dashboard_metricas_entity.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../data/models/dashboard_metricas_model.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc(this.repository, {required UserEntity user})
      : super(DashboardInitial()) {
    on<CargarMetricasEvent>(_onLoadMetricas);
  }

  Future<void> _onLoadMetricas(
    CargarMetricasEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    try {
      final DashboardMetricasModel data = await repository.obtenerMetricas();
      emit(DashboardLoaded(data));
    } catch (e) {
      emit(DashboardError('Error al cargar métricas'));
    }
  }
}
