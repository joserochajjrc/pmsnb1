import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:pmsnb1/settings/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier{

  ThemeProvider(BuildContext context){
    _themeData = StylesApp.lightTheme(context);
    final theme = Theme.of(context);
  }

  ThemeData? _themeData;

  getthemeData() => this._themeData;
  setthemeData(ThemeData theme ){
    this._themeData = theme;
    notifyListeners();
  }
}
  /*final ThemeCollection1 = ThemeCollection(
      themes: {
        0: ThemeData(primarySwatch: Colors.blue),
        1: ThemeData(primarySwatch: Colors.red),
        2: ThemeData.dark(),
      }
    );

  Theme? _theme;
  

  getthemeData() => this._theme;
  setthemeData(ThemeData theme ){
    this._theme = theme as Theme?;
    notifyListeners();
  }



class AppThemes {
    static const int LightBlue = 0;
    static const int LightRed = 1;
    static const int Dark = 2;
}
final themeCollection = ThemeCollection(
    themes: {
        AppThemes.LightBlue: ThemeData(primarySwatch: Colors.blue),
        AppThemes.LightRed: ThemeData(primarySwatch: Colors.red),
        AppThemes.Dark: ThemeData.dark(),
    },
    fallbackTheme: ThemeData.light(),
);*/