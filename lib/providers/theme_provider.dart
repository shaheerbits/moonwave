import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  fontFamily: 'Inter',
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  )
);

ThemeData lightMode = ThemeData(
  fontFamily: 'Inter',
    colorScheme: ColorScheme.light(
      surface: Color.fromRGBO(228, 228, 228, 1),
      primary: Colors.grey.shade200,
      secondary: Colors.grey.shade600,
      inversePrimary: Color.fromRGBO(56, 56, 56, 1),
    )
);

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = lightMode;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == darkMode ? lightMode : darkMode;
    notifyListeners();
  }
}