import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmsnb1/provider/flags_provider.dart';
import 'package:pmsnb1/provider/theme_provider.dart';
import 'package:pmsnb1/routes.dart';
import 'package:pmsnb1/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final theme = sharedPreferences.getString('theme') ?? 'light';
  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final String theme;
  const MyApp({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(theme)),
        ChangeNotifierProvider(create: (context) => FlagsProvider()),
      ],
      
      child: PMSNApp()
    );
  }
}

class PMSNApp extends StatelessWidget {
  PMSNApp({super.key});

  @override
  Widget build(BuildContext context) {

    final settings = Provider.of<ThemeProvider>(context);

    return MaterialApp(
        theme: settings.currentTheme,
        routes: getApplicationRoutes(),
        home: LoginScreen(),
      );
  }
}