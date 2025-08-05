// features/personalizar/presentation/bloc/personalizar_event.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/bebida_entity.dart';
import '../../domain/entities/tamal_entity.dart';

abstract class PersonalizarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CargarOpcionesPersonalizacion extends PersonalizarEvent {}

class AgregarTamalAlCarrito extends PersonalizarEvent {
  final TamalEntity tamal;

  AgregarTamalAlCarrito(this.tamal);

  @override
  List<Object?> get props => [tamal];
}

class AgregarBebidaAlCarrito extends PersonalizarEvent {
  final BebidaEntity bebida;

  AgregarBebidaAlCarrito(this.bebida);

  @override
  List<Object?> get props => [bebida];
}
