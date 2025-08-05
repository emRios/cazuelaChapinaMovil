// lib/features/personalizar/presentation/personalizar_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/personalizar_bloc.dart';
import 'bloc/personalizar_event.dart';
import 'bloc/personalizar_state.dart';

class PersonalizarScreen extends StatefulWidget {
  const PersonalizarScreen({super.key});

  @override
  State<PersonalizarScreen> createState() => _PersonalizarScreenState();
}

class _PersonalizarScreenState extends State<PersonalizarScreen> {
  String? masa, relleno, envoltura, picante;
  String? tipoBebida, tamanioBebida, endulzante, topping;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personalizar Pedido')),
      body: BlocBuilder<PersonalizarBloc, PersonalizarState>(
        builder: (context, state) {
          if (state is PersonalizarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PersonalizarLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tu Tamal",
                      style: Theme.of(context).textTheme.titleLarge),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Masa"),
                    value: masa,
                    items: state.tamalOpciones.masas
                        .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                        .toList(),
                    onChanged: (v) => setState(() => masa = v),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Relleno"),
                    value: relleno,
                    items: state.tamalOpciones.masas
                        .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                        .toList(),
                    onChanged: (v) => setState(() => relleno = v),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Envoltura"),
                    value: envoltura,
                    items: state.tamalOpciones.masas
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => envoltura = v),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Picante"),
                    value: picante,
                    items: state.tamalOpciones.masas
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (v) => setState(() => picante = v),
                  ),
                  const SizedBox(height: 24),
                  Text("Tu Bebida",
                      style: Theme.of(context).textTheme.titleLarge),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Tipo"),
                    value: tipoBebida,
                    items: state.bebidaOpciones.tipos
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (v) => setState(() => tipoBebida = v),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Tamaño"),
                    value: tamanioBebida,
                    items: state.bebidaOpciones.tipos
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (v) => setState(() => tamanioBebida = v),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Endulzante"),
                    value: endulzante,
                    items: state.bebidaOpciones.tipos
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => endulzante = v),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: "Topping"),
                    value: topping,
                    items: state.bebidaOpciones.tipos
                        .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                        .toList(),
                    onChanged: (v) => setState(() => topping = v),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: (masa != null &&
                            relleno != null &&
                            envoltura != null &&
                            picante != null &&
                            tipoBebida != null &&
                            tamanioBebida != null &&
                            endulzante != null &&
                            topping != null)
                        ? () {
                            final seleccion = {
                              "tamales": {
                                "masa": masa,
                                "relleno": relleno,
                                "envoltura": envoltura,
                                "picante": picante
                              },
                              "bebidas": {
                                "tipo": tipoBebida,
                                "tamanio": tamanioBebida,
                                "endulzante": endulzante,
                                "topping": topping
                              }
                            };
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: const Text("Selección"),
                                      content: Text(seleccion.toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("OK"),
                                        )
                                      ],
                                    ));
                          }
                        : null,
                    child: Text("Agregar al carrito"),
                  )
                ],
              ),
            );
          } else if (state is PersonalizarError) {
            return Center(
                child:
                    Text(state.mensaje, style: TextStyle(color: Colors.red)));
          }
          return const Center(child: Text('Pulsa para cargar opciones'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.refresh),
        onPressed: () => context
            .read<PersonalizarBloc>()
            .add(CargarOpcionesPersonalizacion()),
      ),
    );
  }
}
