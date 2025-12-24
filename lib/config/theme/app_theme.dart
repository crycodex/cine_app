import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme({required bool isDarkMode}) {
    final brightness = isDarkMode ? Brightness.dark : Brightness.light;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: const Color(0xFF2196F3),
      onPrimary: Colors.white,
      secondary: const Color(0xFF1976D2),
      onSecondary: Colors.white,
      tertiary: const Color(0xFF0D47A1),
      onTertiary: Colors.white,
      error: const Color(0xFFB00020),
      onError: Colors.white,
      surface: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
      onSurface: isDarkMode ? Colors.white : Colors.black,
      surfaceContainerHighest: isDarkMode ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5),
      onSurfaceVariant: isDarkMode ? Colors.grey[300]! : Colors.grey[700]!,
      outline: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
      outlineVariant: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: isDarkMode ? Colors.white : Colors.black,
      onInverseSurface: isDarkMode ? Colors.black : Colors.white,
      inversePrimary: const Color(0xFF64B5F6),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isDarkMode
          ? Colors.black
          : Colors.white,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: isDarkMode ? 4 : 2,
        color: isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 8,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: isDarkMode ? Colors.grey[500] : Colors.grey[700],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDarkMode
            ? Colors.grey[800]?.withValues(alpha: 0.5)
            : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode
                ? Colors.grey[700]!
                : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
        thickness: 1,
      ),
      iconTheme: IconThemeData(
        color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
      ),
    );
  }
}
