import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Added Hive import
import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Access the same box
  final _myBox = Hive.box('music_box');

  // initially light mode
  ThemeData _themeData = lightMode;

  // Constructor
  ThemeProvider() {
    loadTheme();
  }

  // get theme
  ThemeData get themeData => _themeData;

  // is dark mode
  bool get isDarkMode => _themeData == darkMode;

  // set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    // update ui
    notifyListeners();
  }

  // Load theme preference from Hive
  void loadTheme() {
    bool isDark = _myBox.get('IS_DARK_MODE', defaultValue: false);
    if (isDark) {
      _themeData = darkMode;
    } else {
      _themeData = lightMode;
    }
    notifyListeners();
  }

  // toggle theme method
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
      _myBox.put('IS_DARK_MODE', true);
    } else {
      themeData = lightMode;
      _myBox.put('IS_DARK_MODE', false);
    }
  }
}