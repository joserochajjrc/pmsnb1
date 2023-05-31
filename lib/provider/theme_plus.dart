import 'package:flutter/material.dart';
import 'package:pmsnb1/settings/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider2 with ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeData get currentTheme => _currentTheme;

  String getTheme() {
    String theme = "red";
    if (_currentTheme == StylesApp.redTheme()) {
      theme = 'red';
    }
    if (_currentTheme == StylesApp.ecoTheme()) {
      theme = 'eco';
    }
    return theme;
  }

  ThemeProvider2(String theme) {
    switch (theme) {
      case 'red':
        _currentTheme = StylesApp.redTheme();
        break;
      case 'eco':
        _currentTheme = StylesApp.ecoTheme();
        break;
      default:
        _currentTheme = StylesApp.ecoTheme();
        break;
    }
  }

  void toggleTheme(theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    switch (theme) {
      case 'red':
        _currentTheme = StylesApp.redTheme();
        sharedPreferences.setString('theme', 'red');
        break;
      case 'eco':
        _currentTheme = StylesApp.ecoTheme();
        sharedPreferences.setString('theme', 'eco');
        break;
      default:
        _currentTheme = StylesApp.redTheme();
        sharedPreferences.setString('theme', 'red');
        break;
    }
    notifyListeners();
  }
}