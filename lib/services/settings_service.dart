import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const _themeKey = 'theme_mode';

  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    // Default to false (light mode) if not set
    return prefs.getBool(_themeKey) ?? false;
  }

  Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDark);
  }
}
