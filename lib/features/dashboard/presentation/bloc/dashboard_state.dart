import 'package:equatable/equatable.dart';
import '../../domain/entities/dashboard_metricas_entity.dart';

/// Define los estados que puede tener el DashboardBloc.
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial del dashboard.
class DashboardInitial extends DashboardState {}

/// Estado mientras se cargan las métricas.
class DashboardLoading extends DashboardState {}

/// Estado cuando las métricas se han cargado exitosamente.
class DashboardLoaded extends DashboardState {
  final DashboardMetricasEntity metricas;

  const DashboardLoaded(this.metricas);

  @override
  List<Object?> get props => [metricas];
}

/// Estado si ocurre un error al cargar las métricas.
class DashboardError extends DashboardState {
  final String mensaje;

  const DashboardError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}
