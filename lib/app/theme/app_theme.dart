import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(0xFF44F1A6),
      scaffoldBackgroundColor: const Color(0xFFF5F6F6),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF44F1A6),
        primary: const Color(0xFF44F1A6),
        secondary: const Color(0xFF072126),
        surface: const Color(0xFFFFFFFF),
        error: const Color(0xFFF5585B),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Color(0xFF072126),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      // Add dark theme details here if needed
    );
  }
}
