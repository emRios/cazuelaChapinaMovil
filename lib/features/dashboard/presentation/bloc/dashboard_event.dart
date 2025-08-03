import 'package:equatable/equatable.dart';

/// Define los eventos que puede recibir el DashboardBloc.
abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

/// Evento que indica que deben cargarse las métricas del dashboard.
class CargarMetricasEvent extends DashboardEvent {}
