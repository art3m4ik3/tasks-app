import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String _locale = 'en';

  ThemeMode get themeMode => _themeMode;
  String get locale => _locale;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLocale(String locale) {
    _locale = locale;
    notifyListeners();
  }
}
