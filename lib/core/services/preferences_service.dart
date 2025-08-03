import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final SharedPreferences _prefs;

  // Constructor que exige la instancia de SharedPreferences
  PreferencesService(this._prefs);

  // Guarda un String
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  // Obtiene un String
  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Guarda un int
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  // Obtiene un int
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Guarda un bool
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  // Obtiene un bool
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Elimina un valor
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Limpia todas las preferencias
  Future<bool> clear() async {
    return await _prefs.clear();
  }
}
