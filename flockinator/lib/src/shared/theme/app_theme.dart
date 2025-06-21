import 'package:flutter/material.dart';

class AppTheme {
  // Color constants
  static const Color primaryColor = Color(0xFF0553B1);
  static const Color darkAccentColor = Color(0xFF042B59);
  static const Color lightAccentColor = Color(0xFF027DFD);

  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        primary: primaryColor,
        secondary: lightAccentColor,
        tertiary: darkAccentColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: primaryColor,
            brightness: Brightness.dark,
            primary: primaryColor,
            secondary: lightAccentColor,
            tertiary: darkAccentColor,
          ).copyWith(
            // Enhance surface colors for better contrast
            surface: const Color(0xFF1E1E1E),
            surfaceContainerHighest: const Color(0xFF2D2D2D),
            outline: const Color(0xFF404040),
            outlineVariant: const Color(0xFF505050),
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkAccentColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // Enhanced card styling for dark mode
        color: const Color(0xFF2D2D2D),
        shadowColor: Colors.black54,
        margin: const EdgeInsets.only(bottom: 12.0),
        // Add subtle border for better definition
        surfaceTintColor: const Color(0xFF404040),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: lightAccentColor, width: 2),
        ),
      ),
    );
  }
}
