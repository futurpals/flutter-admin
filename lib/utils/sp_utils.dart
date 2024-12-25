import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static final SpUtils _instance = SpUtils._internal();

  factory SpUtils() {
    return _instance;
  }

  SpUtils._internal();

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool isEmpty(String key) {
    return _prefs?.getString(key) == null;
  }

  // Helper method for setting a string value
  static Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  // Helper method for getting a string value
  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Helper method for setting a boolean value
  static Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  // Helper method for getting a boolean value
  static bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  // Add more helper methods for other types as needed (int, double, List<String>...)

  // Method to clear specific key
  static Future<bool> remove(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  // Method to clear all keys
  static Future<bool> clear() async {
    return await _prefs?.clear() ?? false;
  }
}
