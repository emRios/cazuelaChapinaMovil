// features/personalizar/presentation/bloc/personalizar_bloc.dart

import 'package:cazuela_movil/features/auth/domain/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/tamal_mode.dart';
import '../../data/repositories/personalizar_repository.dart';
import '../../domain/entities/bebida_entity.dart';
import '../../domain/entities/tamal_entity.dart';
import 'personalizar_event.dart';
import 'personalizar_state.dart';
import '../../data/models/bebida_model.dart';

class PersonalizarBloc extends Bloc<PersonalizarEvent, PersonalizarState> {
  final PersonalizarRepository repository;

  // Carrito temporal (en memoria)
  final List<TamalEntity> _tamalesCarrito = [];
  final List<BebidaEntity> _bebidasCarrito = [];

  TamalOpcionesModel? _tamalOpciones;
  BebidaOpcionesModel? _bebidaOpciones;

  PersonalizarBloc({required this.repository, required UserEntity user})
      : super(PersonalizarLoading()) {
    on<CargarOpcionesPersonalizacion>((event, emit) async {
      emit(PersonalizarLoading());
      try {
        _tamalOpciones =
            await repository.obtenerOpcionesTamal(token: user.token);
        _bebidaOpciones =
            (await repository.obtenerOpcionesBebida(token: user.token));

        // ignore: avoid_print
        print('_tamalOpciones.masas: ${_tamalOpciones?.masas}');
        // ignore: avoid_print
        print('_tamalOpciones.rellenos: ${_tamalOpciones?.rellenos}');

        emit(PersonalizarLoaded(
          tamalOpciones: _tamalOpciones!,
          bebidaOpciones: _bebidaOpciones!,
          tamalesCarrito: List.from(_tamalesCarrito),
          bebidasCarrito: List.from(_bebidasCarrito),
        ));
      } catch (e) {
        emit(PersonalizarError("Error al cargar opciones de personalización"));
      }
    });

    on<AgregarTamalAlCarrito>((event, emit) {
      _tamalesCarrito.add(event.tamal);
      if (_tamalOpciones != null && _bebidaOpciones != null) {
        emit(PersonalizarLoaded(
          tamalOpciones: _tamalOpciones!,
          bebidaOpciones: _bebidaOpciones!,
          tamalesCarrito: List.from(_tamalesCarrito),
          bebidasCarrito: List.from(_bebidasCarrito),
        ));
      }
    });

    on<AgregarBebidaAlCarrito>((event, emit) {
      _bebidasCarrito.add(event.bebida);
      if (_tamalOpciones != null && _bebidaOpciones != null) {
        emit(PersonalizarLoaded(
          tamalOpciones: _tamalOpciones!,
          bebidaOpciones: _bebidaOpciones!,
          tamalesCarrito: List.from(_tamalesCarrito),
          bebidasCarrito: List.from(_bebidasCarrito),
        ));
      }
    });
  }
}
