import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeService extends ChangeNotifier {
  bool isDarkModeOn = false;
  static const String _themeBoxName = 'themeBox';
  static const String _themeKey = 'theme';

  ThemeService() {
    _init();
  }

  Future<void> _init() async {
    await Hive.initFlutter();
    var box = await Hive.openBox(_themeBoxName);
    isDarkModeOn = box.get(_themeKey, defaultValue: false);
    notifyListeners();
  }

  void toggleTheme() {
    isDarkModeOn = !isDarkModeOn;
    _saveThemeMode(isDarkModeOn);
    notifyListeners();
  }

  Future<void> _saveThemeMode(bool isDarkModeOn) async {
    var box = await Hive.openBox(_themeBoxName);
    box.put(_themeKey, isDarkModeOn);
    await box.close();
  }
}