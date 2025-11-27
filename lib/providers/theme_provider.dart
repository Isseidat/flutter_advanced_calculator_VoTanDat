import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF1E1E1E),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF1E1E1E),
          secondary: const Color(0xFF424242),
          secondaryContainer: const Color(0xFFE0E0E0),
          tertiary: const Color(0xFFFF6B6B),
        ),
        fontFamily: 'Roboto',
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF121212),
          secondary: const Color(0xFF2C2C2C),
          secondaryContainer: const Color(0xFF1E1E1E),
          tertiary: const Color(0xFF4ECDC4),
        ),
        fontFamily: 'Roboto',
      );

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
