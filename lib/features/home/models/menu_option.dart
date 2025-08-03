import 'package:flutter/material.dart';

class MenuOption {
  final String nombre;
  final IconData icono;
  final String ruta;
  final String modulo;

  const MenuOption({
    required this.nombre,
    required this.icono,
    required this.ruta,
    required this.modulo,
  });
}
