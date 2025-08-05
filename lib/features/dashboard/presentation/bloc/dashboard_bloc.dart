import 'package:cazuela_movil/features/auth/domain/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../../data/models/dashboard_metricas_model.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;
  final UserEntity user;

  DashboardBloc(this.repository, this.user) : super(DashboardInitial()) {
    on<CargarMetricasEvent>(_onLoadMetricas);
  }

  Future<void> _onLoadMetricas(
    CargarMetricasEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    try {
      final DashboardMetricasModel data =
          await repository.obtenerMetricas(token: user.token);

      emit(DashboardLoaded(data));
    } catch (e) {
      emit(const DashboardError('Error al cargar métricas'));
    }
  }
}
