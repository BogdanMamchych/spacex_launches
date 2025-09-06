import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg = Color(0xFF000000);
  static const Color accentGreen = Color(0xFFBFFF33);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bg,
    colorScheme: const ColorScheme.dark(primary: Colors.indigo, secondary: accentGreen),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(color: Colors.white70),
      titleSmall: TextStyle(color: Colors.grey, fontSize: 13),
    ),
  );
}
