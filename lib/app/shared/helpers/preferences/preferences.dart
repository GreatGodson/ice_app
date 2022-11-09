import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preferences;

  static Future<void> clear() async {
    await preferences.clear();
  }

  static Future<void> initalize() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setInt({
    required String key,
    required int value,
  }) {
    return preferences.setInt(key, value);
  }

  static Future<bool> setString({
    required String key,
    required String value,
  }) {
    return preferences.setString(key, value);
  }

  static Future<bool> setBool({
    required String key,
    required bool value,
  }) {
    return preferences.setBool(key, value);
  }

  static String? getString(String key) {
    return preferences.getString(key);
  }

  static bool? getBool(String key) {
    return preferences.getBool(key);
  }

  static int? getInt(String key) {
    return preferences.getInt(key);
  }

  static Future<void> remove(String key) async {
    await preferences.remove(key);
  }

  static Future<bool> setStringList(
      {required String key, required List<String> value}) {
    return preferences.setStringList(key, value);
  }

  static List<String>? getStringList(String key) {
    return preferences.getStringList(key);
  }
}
