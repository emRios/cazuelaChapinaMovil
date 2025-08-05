// features/personalizar/presentation/pages/personalizar_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities/bebida_entity.dart';
import '../domain/entities/tamal_entity.dart';
import '../presentacion/bloc/personalizar_bloc.dart';
import '../presentacion/bloc/personalizar_event.dart';
import '../presentacion/bloc/personalizar_state.dart';

class PersonalizarScreen extends StatefulWidget {
  const PersonalizarScreen({Key? key}) : super(key: key);

  @override
  State<PersonalizarScreen> createState() => _PersonalizarScreenState();
}

class _PersonalizarScreenState extends State<PersonalizarScreen> {
  // Estados locales para los selectores
  String? masa;
  String? relleno;
  String? envoltura;
  String? picante;
  int cantidadTamal = 1;

  String? tamanio;
  String? tipo;
  String? endulzante;
  String? topping;
  int cantidadBebida = 1;

  @override
  void initState() {
    super.initState();
    context.read<PersonalizarBloc>().add(CargarOpcionesPersonalizacion());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalizar Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PersonalizarBloc, PersonalizarState>(
          builder: (context, state) {
            if (state is PersonalizarLoaded) {
              // Inicializar valores si son null
              masa ??= state.tamalOpciones.masas.first;
              relleno ??= state.tamalOpciones.rellenos.first;
              envoltura ??= state.tamalOpciones.envolturas.first;
              picante ??= state.tamalOpciones.nivelesPicante.first;
              tamanio ??= state.bebidaOpciones.tamanios.first;
              tipo ??= state.bebidaOpciones.tipos.first;
              endulzante ??= state.bebidaOpciones.endulzantes.first;
              topping ??= state.bebidaOpciones.toppings.first;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text("Personaliza tu Tamal",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: masa,
                      items: state.tamalOpciones.masas
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => masa = v),
                      decoration:
                          const InputDecoration(labelText: "Tipo de masa"),
                    ),
                    DropdownButtonFormField<String>(
                      value: relleno,
                      items: state.tamalOpciones.rellenos
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => relleno = v),
                      decoration: const InputDecoration(labelText: "Relleno"),
                    ),
                    DropdownButtonFormField<String>(
                      value: envoltura,
                      items: state.tamalOpciones.envolturas
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => envoltura = v),
                      decoration: const InputDecoration(labelText: "Envoltura"),
                    ),
                    DropdownButtonFormField<String>(
                      value: picante,
                      items: state.tamalOpciones.nivelesPicante
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => picante = v),
                      decoration: const InputDecoration(labelText: "Picante"),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Cantidad"),
                      initialValue: cantidadTamal.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (v) =>
                          setState(() => cantidadTamal = int.tryParse(v) ?? 1),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PersonalizarBloc>().add(
                              AgregarTamalAlCarrito(
                                TamalEntity(
                                  masa: masa!,
                                  relleno: relleno!,
                                  envoltura: envoltura!,
                                  picante: picante!,
                                  cantidad: cantidadTamal,
                                ),
                              ),
                            );
                      },
                      child: const Text("Agregar Tamal"),
                    ),
                    const Divider(height: 24),
                    const Text("Personaliza tu Bebida",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: tamanio,
                      items: state.bebidaOpciones.tamanios
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => tamanio = v),
                      decoration: const InputDecoration(labelText: "Tamaño"),
                    ),
                    DropdownButtonFormField<String>(
                      value: tipo,
                      items: state.bebidaOpciones.tipos
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => tipo = v),
                      decoration:
                          const InputDecoration(labelText: "Tipo de bebida"),
                    ),
                    DropdownButtonFormField<String>(
                      value: endulzante,
                      items: state.bebidaOpciones.endulzantes
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => endulzante = v),
                      decoration:
                          const InputDecoration(labelText: "Endulzante"),
                    ),
                    DropdownButtonFormField<String>(
                      value: topping,
                      items: state.bebidaOpciones.toppings
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (v) => setState(() => topping = v),
                      decoration: const InputDecoration(
                          labelText: "Topping (opcional)"),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Cantidad"),
                      initialValue: cantidadBebida.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (v) =>
                          setState(() => cantidadBebida = int.tryParse(v) ?? 1),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PersonalizarBloc>().add(
                              AgregarBebidaAlCarrito(
                                BebidaEntity(
                                  tamanio: tamanio!,
                                  tipo: tipo!,
                                  endulzante: endulzante!,
                                  topping: topping!,
                                  cantidad: cantidadBebida,
                                ),
                              ),
                            );
                      },
                      child: const Text("Agregar Bebida"),
                    ),
                    const Divider(height: 24),
                    const Text("Resumen temporal de selección",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (state.tamalesCarrito.isEmpty &&
                        state.bebidasCarrito.isEmpty)
                      const Text("No has agregado productos aún.",
                          style: TextStyle(color: Colors.grey)),
                    ...state.tamalesCarrito.map((t) => ListTile(
                          leading: const Icon(Icons.local_dining),
                          title: Text(
                              "${t.cantidad} tamal(es): ${t.masa}, ${t.relleno}, ${t.envoltura}, ${t.picante}"),
                        )),
                    ...state.bebidasCarrito.map((b) => ListTile(
                          leading: const Icon(Icons.local_cafe),
                          title: Text(
                              "${b.cantidad} bebida(s): ${b.tamanio}, ${b.tipo}, ${b.endulzante}, ${b.topping}"),
                        )),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
