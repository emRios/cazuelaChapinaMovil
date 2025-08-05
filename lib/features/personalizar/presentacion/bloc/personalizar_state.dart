// features/personalizar/presentation/bloc/personalizar_state.dart

import 'package:equatable/equatable.dart';
import '../../data/models/tamal_mode.dart';
import '../../data/models/bebida_model.dart';
import '../../domain/entities/bebida_entity.dart';
import '../../domain/entities/tamal_entity.dart';

abstract class PersonalizarState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PersonalizarLoading extends PersonalizarState {}

class PersonalizarLoaded extends PersonalizarState {
  final TamalOpcionesModel tamalOpciones;
  final BebidaOpcionesModel bebidaOpciones;
  final List<TamalEntity> tamalesCarrito;
  final List<BebidaEntity> bebidasCarrito;

  PersonalizarLoaded({
    required this.tamalOpciones,
    required this.bebidaOpciones,
    this.tamalesCarrito = const [],
    this.bebidasCarrito = const [],
  });

  @override
  List<Object?> get props =>
      [tamalOpciones, bebidaOpciones, tamalesCarrito, bebidasCarrito];
}

class PersonalizarError extends PersonalizarState {
  final String mensaje;

  PersonalizarError(this.mensaje);

  @override
  List<Object?> get props => [mensaje];
}
