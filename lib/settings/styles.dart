import 'package:flutter/material.dart';

class StylesApp {
  
  //static Color appPrimaryColor = Color.fromARGB(255, 6, 126, 122);

  static ThemeData darkTheme (BuildContext context){
    final ThemeData theme = ThemeData.dark();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(primary: Color.fromARGB(255, 81, 82, 66))
    );
  }

   static ThemeData lightTheme (BuildContext context){
    final ThemeData theme = ThemeData.light();
    return theme.copyWith(
      colorScheme: Theme.of(context).colorScheme.copyWith(primary: Color.fromARGB(255, 8, 103, 38))
    );
  }

  static ThemeData ecoTheme() {
    return ThemeData.from(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 68, 219, 68),
          onPrimary: Colors.white,
          secondary: Color(0xff8b4513),
          onSecondary: Colors.white,
          error: Color(0xffb00020),
          onError: Colors.white,
          background: Colors.white,
          onBackground: Colors.black,
          surface: Color(0xffe6d8ad),
          onSurface: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Coolvetica'),
          bodyMedium: TextStyle(fontFamily: 'Coolvetica'),
          bodySmall: TextStyle(fontFamily: 'Coolvetica'),
          displayLarge: TextStyle(fontFamily: 'Coolvetica'),
          displayMedium: TextStyle(fontFamily: 'Coolvetica'),
          displaySmall: TextStyle(fontFamily: 'Coolvetica'),
          labelLarge: TextStyle(fontFamily: 'Coolvetica'),
          labelMedium: TextStyle(fontFamily: 'Coolvetica'),
          labelSmall: TextStyle(fontFamily: 'Coolvetica'),
          titleLarge: TextStyle(fontFamily: 'Coolvetica'),
          titleMedium: TextStyle(fontFamily: 'Coolvetica'),
          titleSmall: TextStyle(fontFamily: 'Coolvetica'),
        ));
  }

  static ThemeData redTheme() {
    return ThemeData.from(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 156, 60, 70),
          onPrimary: Colors.white,
          secondary: Color(0xff8b4513),
          onSecondary: Colors.white,
          error: Color(0xffb00020),
          onError: Colors.white,
          background: Color.fromARGB(255, 123, 118, 34),
          onBackground: Colors.black,
          surface: Color(0xffe6d8ad),
          onSurface: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Coolvetica'),
          bodyMedium: TextStyle(fontFamily: 'Coolvetica'),
          bodySmall: TextStyle(fontFamily: 'Coolvetica'),
          displayLarge: TextStyle(fontFamily: 'Coolvetica'),
          displayMedium: TextStyle(fontFamily: 'Coolvetica'),
          displaySmall: TextStyle(fontFamily: 'Coolvetica'),
          labelLarge: TextStyle(fontFamily: 'Coolvetica'),
          labelMedium: TextStyle(fontFamily: 'Coolvetica'),
          labelSmall: TextStyle(fontFamily: 'Coolvetica'),
          titleLarge: TextStyle(fontFamily: 'Coolvetica'),
          titleMedium: TextStyle(fontFamily: 'Coolvetica'),
          titleSmall: TextStyle(fontFamily: 'Coolvetica'),
        ));
  }

}