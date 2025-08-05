import 'package:flutter/foundation.dart';
import 'dart:io';

/// Ajusta esta IP a la dirección local de tu PC cuando uses un dispositivo físico.
/// Puedes obtenerla con `ipconfig` (Windows) o `ifconfig` (Linux/Mac).
const String localHostIP = '192.168.0.5'; // ← CAMBIA ESTO según tu red local

/// Devuelve la base URL para consumir el backend dependiendo del entorno.
String getBaseUrl() {
  // 🚀 Producción (flutter build apk --release)
  if (kReleaseMode) {
    return 'https://api.tudominio.com/api/';
  }

  // 🌐 Flutter Web (por si alguna vez migras a web)
  if (kIsWeb) {
    return 'http://localhost:9000';
  }

  // 📱 Emulador Android
  if (Platform.isAndroid) {
    return 'http://10.0.2.2:9000';
  }

  // 📲 Dispositivo físico u otro sistema (ej: iOS, desktop)
  return 'http://$localHostIP:9000';
}


// String getBaseUrl() {
//   if (kReleaseMode) {
//     return 'https://api.tudominio.com/api/';
//   }

//   if (kIsWeb) {
//     return 'http://localhost:9000/';
//   }

//   // Detectar emulador Android durante el desarrollo
//   if (Platform.isAndroid && kDebugMode) {
//     return 'http://10.0.2.2:9000/';
//   }

//   // Si no es producción, web o emulador, asume que es un dispositivo físico u otro entorno
//   return 'http://$localHostIP:9000/';
// }