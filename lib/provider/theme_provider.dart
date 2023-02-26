import 'package:flutter/material.dart';
import 'package:pmsnb1/settings/styles.dart';

class ThemeProvider with ChangeNotifier{

  ThemeProvider(BuildContext context){
    _themeData = StylesApp.lightTheme(context);
  }

  ThemeData? _themeData;

  getthemeData() => this._themeData;
  setthemeData(ThemeData theme ){
    this._themeData = theme;
    notifyListeners();
  }

}