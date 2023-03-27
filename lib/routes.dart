import 'package:flutter/material.dart';
import 'package:pmsnb1/screens/dashboard_screen.dart';
import 'package:pmsnb1/screens/events_screen.dart';
import 'package:pmsnb1/screens/login_screen.dart';
import 'package:pmsnb1/screens/onboarding_screen.dart';
import 'package:pmsnb1/screens/popular_movies_screen.dart';
import 'package:pmsnb1/screens/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/register': (BuildContext context) => RegisterScreen(),
    '/login':(BuildContext context) => LoginScreen(), 
    '/dash':(BuildContext context) => DashboardScreen(),
    '/onboarding':(BuildContext context) => OnboardingScreen(),
    '/popular':(BuildContext context) => PopularMoviesScreen(),
    '/events':(BuildContext context) => eventsScreen(),
  };
}