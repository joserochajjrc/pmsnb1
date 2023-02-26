import 'package:flutter/material.dart';
import 'package:pmsnb1/screens/dashboard_screen.dart';
import 'package:pmsnb1/screens/login_screen.dart';
import 'package:pmsnb1/screens/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => RegisterScreen(),
    '/login':(BuildContext context) => LoginScreen(), 
    '/dash':(BuildContext context) => DashboardScreen()
  };
}