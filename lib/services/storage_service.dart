import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/calculation_history.dart';

class StorageService {
  static const String historyKey = 'history';
  static const String themeKey = 'theme';
  static const String modeKey = 'mode';
  static const String memoryKey = 'memory';
  static const String angleKey = 'angle';

  static Future<void> saveHistory(List<CalculationHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = history.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(historyKey, jsonList);
  }

  static Future<List<CalculationHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(historyKey) ?? [];
    return list.map((e) => CalculationHistory.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> saveTheme(int themeIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeKey, themeIndex);
  }

  static Future<int?> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(themeKey);
  }

  static Future<void> saveMode(int modeIndex) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(modeKey, modeIndex);
  }

  static Future<int?> loadMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(modeKey);
  }

  static Future<void> saveMemory(double memory) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(memoryKey, memory);
  }

  static Future<double?> loadMemory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(memoryKey);
  }

  static Future<void> saveAngle(bool isDeg) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(angleKey, isDeg);
  }

  static Future<bool?> loadAngle() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(angleKey);
  }
}
