import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

enum AppThemeMode {
  light,
  dark,
}

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  static const String _themeKey = 'theme_mode';
  bool _isInitialized = false;

  ThemeNotifier() : super(AppThemeMode.light) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    if (_isInitialized) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeIndex = prefs.getInt(_themeKey);
      if (themeIndex != null && 
          themeIndex >= 0 && 
          themeIndex < AppThemeMode.values.length) {
        state = AppThemeMode.values[themeIndex];
      } else {
        state = AppThemeMode.light;
        await prefs.setInt(_themeKey, AppThemeMode.light.index);
      }
      _isInitialized = true;
    } catch (e) {
      state = AppThemeMode.light;
      _isInitialized = true;
    }
  }

  Future<void> toggleTheme() async {
    final newTheme = state == AppThemeMode.light
        ? AppThemeMode.dark
        : AppThemeMode.light;
    await setTheme(newTheme);
  }

  Future<void> setTheme(AppThemeMode mode) async {
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, mode.index);
    } catch (e) {
      debugPrint("error setting theme: $e");
    }
  }

  bool get isDarkMode => state == AppThemeMode.dark;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>((ref) {
  return ThemeNotifier();
});
